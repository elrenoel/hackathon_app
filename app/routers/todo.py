from fastapi import APIRouter, Depends,HTTPException
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

@router.patch("/todos/{todo_id}", response_model=schemas.TodoResponse)
def toggle_todo_done(
    todo_id: int,
    db: Session = Depends(get_db),
    current_user = Depends(oauth2.get_current_user),
):
    todo = (
        db.query(models.Todo)
        .filter(
            models.Todo.id == todo_id,
            models.Todo.user_id == current_user.id,
        )
        .first()
    )

    if not todo:
        raise HTTPException(status_code=404, detail="Todo not found")

    todo.is_done = not todo.is_done
    db.commit()
    db.refresh(todo)

    return todo

@router.delete("/todos/{todo_id}", status_code=204)
def delete_todo(
    todo_id: int,
    db: Session = Depends(get_db),
    current_user = Depends(oauth2.get_current_user),
):
    todo = (
        db.query(models.Todo)
        .filter(
            models.Todo.id == todo_id,
            models.Todo.user_id == current_user.id,
        )
        .first()
    )

    if not todo:
        raise HTTPException(status_code=404, detail="Todo not found")

    db.delete(todo)
    db.commit()
