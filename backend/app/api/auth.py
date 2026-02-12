from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.session import SessionLocal
from app.db.models.user import User
from app.core.security import verify_password, create_access_token

router = APIRouter(prefix="/api/auth", tags=["Auth"])


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/login")
def login(employee_id: str, password: str, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.employee_id == employee_id).first()

    if not user:
        raise HTTPException(status_code=401, detail="Invalid credentials")

    if not verify_password(password, user.password_hash):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    if user.status != "active":
        raise HTTPException(status_code=403, detail="User inactive")

    token = create_access_token(user.id, user.employee_id)

    return {
        "access_token": token,
        "token_type": "bearer"
    }
