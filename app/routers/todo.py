from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app import models
from app import schemas
from app.database import get_db
from app import oauth2

router = APIRouter(prefix="/todos", tags=["Todos"])

@router.post("/todos", response_model=schemas.TodoResponse)
def create_todo(
    todo: schemas.TodoCreate,
    db: Session = Depends(get_db),
    current_user = Depends(oauth2.get_current_user)
):
    new_todo = models.Todo(
      title=todo.title,
      duration=todo.duration,
      start_time=todo.start_time,
      reminder=todo.reminder,
      user_id=current_user.id
    )
    db.add(new_todo)
    db.commit()
    db.refresh(new_todo)
    return new_todo


@router.get("/todos", response_model=list[schemas.TodoResponse])
def get_my_todos(
    db: Session = Depends(get_db),
    current_user = Depends(oauth2.get_current_user)
):
    return db.query(models.Todo)\
        .filter(models.Todo.user_id == current_user.id)\
        .all()
