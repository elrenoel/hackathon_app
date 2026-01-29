from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app import database, schemas, models, utils, oauth2


router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)

# =========================
# SEND OTP
# =========================
@router.post("/register/send-otp")
def send_otp(
    payload: schemas.SendOTPRequest,
    db: Session = Depends(database.get_db)
):
    # 1. email sudah terdaftar?
    if db.query(models.User).filter(
        models.User.email == payload.email
    ).first():
        raise HTTPException(400, "Email already registered")

    # 2. cegah spam OTP
    existing_otp = db.query(models.EmailVerification).filter(
        models.EmailVerification.email == payload.email,
        models.EmailVerification.is_used == False,
        models.EmailVerification.expires_at > datetime.utcnow()
    ).first()

    if existing_otp:
        raise HTTPException(429, "OTP already sent. Please wait.")

    otp = utils.generate_otp()

    record = models.EmailVerification(
        email=payload.email,
        name=payload.name,
        otp=otp,
        expires_at=utils.otp_expiry()
    )

    db.add(record)
    db.commit()

    # kirim email OTP
    utils.send_otp_email(payload.email, otp)

    return {"message": "OTP sent"}


# =========================
# VERIFY OTP
# =========================
@router.post("/register/verify-otp")
def verify_otp(
    payload: schemas.VerifyOTPRequest,
    db: Session = Depends(database.get_db)
):
    record = db.query(models.EmailVerification).filter(
        models.EmailVerification.email == payload.email,
        models.EmailVerification.otp == payload.otp,
        models.EmailVerification.is_used == False
    ).first()

    if not record or record.expires_at < datetime.utcnow():
        raise HTTPException(400, "Invalid or expired OTP")

    record.is_used = True
    db.commit()

    return {"message": "OTP verified"}


# =========================
# SET PASSWORD
# =========================
@router.post("/register/set-password", status_code=201)
def set_password(
    payload: schemas.SetPasswordRequest,
    db: Session = Depends(database.get_db)
):
    verification = db.query(models.EmailVerification).filter(
        models.EmailVerification.email == payload.email,
        models.EmailVerification.is_used == True
    ).first()

    if not verification:
        raise HTTPException(400, "Email not verified")

    user = models.User(
        email=payload.email,
        name=verification.name,
        password=utils.hash_password(payload.password),
        is_verified=True,
    )

    db.add(user)
    db.commit()
    db.refresh(user)

    return {"message": "Account created"}


# =========================
# LOGIN
# =========================
@router.post("/login", response_model=schemas.Token)
def login(
    user_credentials: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(database.get_db)
):
    user = db.query(models.User).filter(
        models.User.email == user_credentials.username
    ).first()

    if not user or not utils.verify_password(
        user_credentials.password, user.password
    ):
        raise HTTPException(status_code=403, detail="Invalid Credentials")

    access_token = oauth2.create_access_token(
        data={"user_id": user.id}
    )

    return {"access_token": access_token, "token_type": "bearer"}
