from passlib.context import CryptContext
import random
from datetime import datetime, timedelta
from dotenv import load_dotenv
import os
import resend


load_dotenv()
resend.api_key = os.getenv("RESEND_API_KEY")

pwd_context = CryptContext(
    schemes=["argon2"],
    deprecated="auto"
)

def hash_password(password: str):
    return pwd_context.hash(password)

def verify_password(plain_password: str, hashed_password: str):
    return pwd_context.verify(plain_password, hashed_password)

def generate_otp():
    return str(random.randint(100000, 999999))

def otp_expiry():
    return datetime.utcnow() + timedelta(minutes=5)


def send_otp_email(to_email: str, otp: str):
    resend.Emails.send({
        "from": os.getenv("EMAIL_FROM"),  # contoh: Neura <onboarding@resend.dev>
        "to": to_email,
        "subject": "Your Neura verification code",
        "html": f"""
        <h2>Your verification code</h2>
        <p><strong>{otp}</strong></p>
        <p>This code will expire in 5 minutes.</p>
        """
    })



def calculate_persona(answers: list[int]) -> str:
    score = 0

    for a in answers:
        if a == 0:
            score += 2
        elif a == 1:
            score += 1
        elif a == 2:
            score += 0

    if score >= 8:
        return "laser_focus"
    elif score >= 4:
        return "ping_pong"
    else:
        return "butterfly"