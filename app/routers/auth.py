from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
# from routers import database, schemas, models, utils, oauth2
from app import database
from app import schemas
from app import models
from app import utils
from app import oauth2


router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)

@router.post("/register",response_model=schemas.UserResponse, status_code=status.HTTP_201_CREATED)
def register(
    user: schemas.UserCreate,
    db: Session = Depends(database.get_db)
):
    hashed_pw = utils.hash_password(user.password)

    new_user = models.User(
        email=user.email,
        password=hashed_pw,
        name= user.name
    )
    existing_name = db.query(models.User).filter(
        models.User.name == user.name).first()

    if existing_name:
        raise HTTPException(
            status_code=400,
            detail="Name already taken"
    )

    try:
        db.add(new_user)
        db.commit()
        db.refresh(new_user)
        return new_user

    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email sudah terdaftar"
        )

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
