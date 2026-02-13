from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.db.models.user import User
from app.core.security import verify_password, create_access_token
from app.api.dependencies import get_current_user


router = APIRouter(prefix="/auth", tags=["Auth"])


@router.post("/login")
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):
    # OAuth2 uses "username" field → map to employee_id
    employee_id = form_data.username
    password = form_data.password

    user = db.query(User).filter(User.employee_id == employee_id).first()

    if not user or not verify_password(password, user.password_hash):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    if user.status != "active":
        raise HTTPException(status_code=403, detail="User inactive")

    token = create_access_token(user.id, user.employee_id)

    # IMPORTANT: OAuth2 requires THIS exact response format
    return {
        "access_token": token,
        "token_type": "bearer"
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
