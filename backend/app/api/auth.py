from fastapi import APIRouter, Depends, HTTPException, Request
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.db.models.user import User
from app.core.security import verify_password, create_access_token
from app.api.dependencies import get_current_user
from app.core.audit import log_action


router = APIRouter(prefix="/auth", tags=["Auth"])


@router.post("/login")
def login(
    request: Request,
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db),
):
    employee_id = form_data.username
    password = form_data.password

    user = db.query(User).filter(User.employee_id == employee_id).first()

    # -----------------------------
    # INVALID USER / PASSWORD
    # -----------------------------
    if not user or not verify_password(password, user.password_hash):

        log_action(
            action="LOGIN_FAILED",
            user_id=user.id if user else None,
            entity_type="auth",
            description=f"Failed login attempt for employee_id: {employee_id}",
            request=request,
        )

        raise HTTPException(status_code=401, detail="Invalid credentials")

    # -----------------------------
    # INACTIVE USER
    # -----------------------------
    if user.status != "active":

        log_action(
            action="LOGIN_FAILED",
            user_id=user.id,
            entity_type="auth",
            description="Login attempt by inactive user",
            request=request,
        )

        raise HTTPException(status_code=403, detail="User inactive")

    # -----------------------------
    # CREATE TOKEN
    # -----------------------------
    token = create_access_token(user.id, user.employee_id)

    # -----------------------------
    # SUCCESS LOGIN
    # -----------------------------
    log_action(
        action="LOGIN_SUCCESS",
        user_id=user.id,
        entity_type="auth",
        description="User logged in successfully",
        request=request,
    )

    return {
        "access_token": token,
        "token_type": "bearer",
    }


@router.get("/me")
def get_me(current_user: User = Depends(get_current_user)):
    return {
        "success": True,
        "data": {
            "id": current_user.id,
            "employee_id": current_user.employee_id,
            "email": current_user.email,
        },
        "message": "User fetched",
    }
