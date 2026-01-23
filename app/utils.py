# # # utils.py
# # from passlib.context import CryptContext

# # pwd_context = CryptContext(schemes=["bcrypt"])

# # def hash(password: str):
# #     return pwd_context.hash(password)

# # def verify(plain, hashed):
# #     return pwd_context.verify(plain, hashed)

# # utils.py
# import hashlib
# from passlib.context import CryptContext

# pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# def hash_password(password: str) -> str:
#     # Pre-hash dengan SHA256 → panjang FIX
#     digest = hashlib.sha256(password.encode("utf-8")).hexdigest()
#     return pwd_context.hash(digest)

# def verify_password(plain_password: str, hashed_password: str) -> bool:
#     digest = hashlib.sha256(plain_password.encode("utf-8")).hexdigest()
#     return pwd_context.verify(digest, hashed_password)

from passlib.context import CryptContext

pwd_context = CryptContext(
    schemes=["argon2"],
    deprecated="auto"
)

def hash_password(password: str):
    return pwd_context.hash(password)

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)
