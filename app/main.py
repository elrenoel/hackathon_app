from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
# from routers import todo
from app.routers import auth
from app.database import Base, engine
from app import models
from app import oauth2
from app import schemas
from app.routers import todo


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
app.include_router(todo.router)


@app.get("/")
def root():
    return {"message": "API is running 🚀"}

# @app.get("/protected")
# def protected_route(current_user = Depends(oauth2.get_current_user)):
#     return {
#         "message": "You are authorized",
#         "id": current_user.id,
#         "name":current_user.name,
#         "email": current_user.email,
#     }
@app.get("/protected", response_model=schemas.UserResponse)
def protected_route(current_user = Depends(oauth2.get_current_user)):
    return current_user
