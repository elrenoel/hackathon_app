from typing import List
from pydantic import BaseModel, EmailStr, Field, field_validator
from datetime import datetime

# =======================
# SUBTASK SCHEMAS (NAIK KE ATAS)
# =======================

class SubtaskBase(BaseModel):
    id: int
    title: str
    is_done: bool
    todo_id: int

    class Config:
        orm_mode = True

class SubtaskCreate(BaseModel):
    title: str

class SubtaskResponse(BaseModel):
    id: int
    title: str
    is_done: bool

    class Config:
        orm_mode = True
        
# OTP Schema

class SendOTPRequest(BaseModel):
    email: EmailStr
    name: str


class VerifyOTPRequest(BaseModel):
    email: EmailStr
    otp: str


class SetPasswordRequest(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8)



# =======================
# USER SCHEMAS
# =======================

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


# =======================
# TODO SCHEMAS
# =======================

class TodoCreate(BaseModel):
    title: str
    duration: str | None = None
    start_time: str | None = None
    reminder: str | None = None
    subtasks: list[SubtaskCreate] = []  # ✅ sekarang sudah dikenal


class TodoResponse(BaseModel):
    id: int
    title: str
    duration: str | None
    start_time: str | None
    reminder: str | None
    is_done: bool

    # 🔥 INI KUNCI
    subtasks: list[SubtaskResponse] = []

    class Config:
        orm_mode = True


# Profilling User

class ProfilingRequest(BaseModel):
    q1: int = Field(ge=1, le=3)
    q2: int = Field(ge=1, le=3)
    q3: int = Field(ge=1, le=3)
    q4: int = Field(ge=1, le=3)
    q5: int = Field(ge=1, le=3)

class ProfilingResponse(BaseModel):
    persona: str
    total_score: int

class ProfilingAnswer(BaseModel):
    question: int
    answer_index: int  # 0,1,2


class ProfilingSubmit(BaseModel):
    answers: List[ProfilingAnswer]

class ProfilingResultResponse(BaseModel):
    persona: str
    score: int
