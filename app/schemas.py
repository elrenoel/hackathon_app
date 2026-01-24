from pydantic import BaseModel, EmailStr, Field, field_validator
from datetime import datetime

class UserBase(BaseModel):
    email: EmailStr
    name: str

class UserCreate(UserBase):
    password: str = Field(min_length=6)
    @field_validator("password")
    @classmethod
    def password_max_72_bytes(cls, v: str):
        if len(v.encode("utf-8")) > 72:
            raise ValueError("Password too long (max 72 bytes)")
        return v

class UserResponse(UserBase):
    id: int
    email: EmailStr
    name: str
    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str

class TodoCreate(BaseModel):
    title: str
    duration: str | None = None
    start_time: str | None = None
    reminder: str | None = None


class TodoResponse(BaseModel):
    id: int
    title: str
    duration: str | None
    start_time: str | None
    reminder: str | None
    is_done: bool

    class Config:
        from_attributes = True
