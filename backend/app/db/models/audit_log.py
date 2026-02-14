from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Text
from sqlalchemy.sql import func
from app.db.base import Base


class AuditLog(Base):
    __tablename__ = "audit_logs"

    id = Column(Integer, primary_key=True, index=True)

    user_id = Column(String, ForeignKey("users.id"), nullable=True)

    action = Column(String(100), nullable=False, index=True)

    entity_type = Column(String(100), nullable=True)

    entity_id = Column(Integer, nullable=True)

    description = Column(Text, nullable=True)

    ip_address = Column(String(50), nullable=True)

    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
