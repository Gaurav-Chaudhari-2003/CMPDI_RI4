from fastapi import Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.api.dependencies import get_current_user
from app.db.models.rbac.user_role import UserRole
from app.db.models.rbac.role_permission import RolePermission
from app.db.models.rbac.permission import Permission


def require_permission(permission_code: str):
    def permission_checker(
        current_user=Depends(get_current_user),
        db: Session = Depends(get_db),
    ):
        # Get all roles assigned to user
        user_roles = db.query(UserRole.role_id).filter(
            UserRole.user_id == current_user.id
        ).all()

        if not user_roles:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="No roles assigned",
            )

        role_ids = [r.role_id for r in user_roles]

        # Get permissions linked to these roles
        permission = (
            db.query(Permission)
            .join(RolePermission, Permission.id == RolePermission.permission_id)
            .filter(
                RolePermission.role_id.in_(role_ids),
                Permission.code == permission_code,
            )
            .first()
        )

        if not permission:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Permission denied",
            )

        return current_user

    return permission_checker
