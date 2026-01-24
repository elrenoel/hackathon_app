from sqlalchemy import Column, Integer,String, Boolean
from sqlalchemy.sql.expression import null,text
from app.database import Base
from sqlalchemy.sql.sqltypes import TIMESTAMP
# models.py
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    email = Column(String, unique=True, nullable=False)
    password = Column(String, nullable=False)
    name = Column(String, unique=True, nullable=False) 