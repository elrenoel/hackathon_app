from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
# from routers import todo
from routers import auth
from database import Base, engine
import models
import oauth2

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # ✅ DEV MODE (biar port flutter bebas)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#venv\Scripts\activate
# app.include_router(todo.router)
app.include_router(auth.router)

@app.get("/")
def root():
    return {"message": "API is running 🚀"}

@app.get("/protected")
def protected_route(current_user = Depends(oauth2.get_current_user)):
    return {
        "message": "You are authorized",
        "user_id": current_user.id,
        "email": current_user.email
    }