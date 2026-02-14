from app.db.models.rbac.user_role import UserRole
print(UserRole.__table__.c.role_id.type)
