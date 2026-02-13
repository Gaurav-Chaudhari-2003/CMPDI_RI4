from app.db.base import Base

# Import ALL models here so Alembic sees them
from app.db.models.user import User  # noqa

from app.db.models.rbac.role import Role
from app.db.models.rbac.permission import Permission
from app.db.models.rbac.role_permission import RolePermission
from app.db.models.rbac.user_role import UserRole
