from datetime import datetime
from sqlalchemy import Column, DateTime, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from app.database import Base

class EmailVerification(Base):
    __tablename__ = "email_verifications"

    id = Column(Integer, primary_key=True)
    email = Column(String, nullable=False)
    name = Column(String, nullable=False)  # ⬅️ TAMBAH
    otp = Column(String, nullable=False)
    expires_at = Column(DateTime, nullable=False)
    is_used = Column(Boolean, default=False)


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    email = Column(String, unique=True, nullable=False)
    password = Column(String, nullable=False)
    name = Column(String, nullable=False)
    is_verified = Column(Boolean, default=False)

    persona = Column(String, nullable=True)
    profiling_completed = Column(Boolean, default=False)
    focus_score = Column(Integer, nullable=True)
    
    todos = relationship("Todo", back_populates="user", cascade="all, delete")


class UserProfiling(Base):
    __tablename__ = "user_profilings"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"))

    q1 = Column(Integer)
    q2 = Column(Integer)
    q3 = Column(Integer)
    q4 = Column(Integer)
    q5 = Column(Integer)

    total_score = Column(Integer)
    persona = Column(String)

    created_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User")


class Todo(Base):
    __tablename__ = "todos"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    duration = Column(String, nullable=True)
    start_time = Column(String, nullable=True)
    reminder = Column(String, nullable=True)
    is_done = Column(Boolean, default=False)

    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"))

    user = relationship("User", back_populates="todos")

    # 🔥 1 todo → banyak subtask
    subtasks = relationship(
        "Subtask",
        back_populates="todo",
        cascade="all, delete-orphan",
    )

class Subtask(Base):
    __tablename__ = "subtasks"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    is_done = Column(Boolean, default=False)

    # 🔥 foreign key ke todo
    todo_id = Column(
        Integer,
        ForeignKey("todos.id", ondelete="CASCADE"),
        nullable=False,
    )

    todo = relationship("Todo", back_populates="subtasks")

