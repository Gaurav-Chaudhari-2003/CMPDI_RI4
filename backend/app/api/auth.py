from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.session import SessionLocal
from app.db.models.user import User
from app.core.security import verify_password, create_access_token
from app.api.deps import get_current_user
from app.schemas.auth import LoginRequest

router = APIRouter(prefix="/auth", tags=["Auth"])


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/login")
def login(request: LoginRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.employee_id == request.employee_id).first()

    if not user or not verify_password(request.password, user.password_hash):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    if user.status != "active":
        raise HTTPException(status_code=403, detail="User inactive")

    token = create_access_token(user.id, user.employee_id)

    return {
        "success": True,
        "data": {
            "access_token": token,
            "token_type": "bearer"
        },
        "message": "Login successful"
    }


@router.get("/me")
def get_me(current_user: User = Depends(get_current_user)):
    return {
        "success": True,
        "data": {
            "id": current_user.id,
            "employee_id": current_user.employee_id,
            "email": current_user.email
        },
        "message": "User fetched"
    }

