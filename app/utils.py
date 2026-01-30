from passlib.context import CryptContext
import random
from datetime import datetime, timedelta
from dotenv import load_dotenv
load_dotenv()

import os
import smtplib
from email.message import EmailMessage

SMTP_EMAIL = os.getenv("SMTP_EMAIL")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD")

pwd_context = CryptContext(
    schemes=["argon2"],
    deprecated="auto"
)

def hash_password(password: str):
    return pwd_context.hash(password)

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def generate_otp():
    return str(random.randint(100000, 999999))


def otp_expiry():
    return datetime.utcnow() + timedelta(minutes=5)

def send_otp_email(to_email: str, otp: str):
    msg = EmailMessage()
    msg["Subject"] = "Your Neura verification code"
    msg["From"] = SMTP_EMAIL
    msg["To"] = to_email
    
    print("SMTP_EMAIL:", SMTP_EMAIL)
    print("SMTP_PASSWORD:", SMTP_PASSWORD)


    msg.set_content(f"""
    Hi 👋

    Your verification code is:

    {otp}

    This code will expire in 5 minutes.
    If you did not request this, please ignore this email.

    — Neura Team
    """)

    with smtplib.SMTP_SSL("smtp.gmail.com", 465) as smtp:
        smtp.login(SMTP_EMAIL, SMTP_PASSWORD)
        smtp.send_message(msg)


