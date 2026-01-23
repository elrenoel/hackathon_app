from fastapi import APIRouter, Depends
from .. import oauth2, schemas

router = APIRouter(prefix="/users", tags=["Users"])

@router.get("/me", response_model=schemas.UserResponse)
def get_me(current_user = Depends(oauth2.get_current_user)):
    return current_user
