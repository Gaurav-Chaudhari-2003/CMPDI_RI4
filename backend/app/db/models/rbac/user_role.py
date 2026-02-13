from sqlalchemy import Column, String, Integer, ForeignKey
from app.db.base import Base


class UserRole(Base):
    __tablename__ = "user_roles"

    user_id = Column(String, ForeignKey("users.id"), primary_key=True)
    role_id = Column(Integer, ForeignKey("roles.id"), primary_key=True)
    domain = Column(String, nullable=True)
    module = Column(String, nullable=True)
