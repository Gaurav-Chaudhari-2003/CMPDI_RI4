from fastapi import Request
from typing import Optional
from sqlalchemy.orm import Session

from app.db.session import SessionLocal
from app.db.models.audit_log import AuditLog


def get_client_ip(request: Request) -> Optional[str]:
    try:
        if "x-forwarded-for" in request.headers:
            return request.headers["x-forwarded-for"].split(",")[0].strip()
        return request.client.host if request.client else None
    except Exception:
        return None


def log_action(
    action: str,
    user_id: Optional[str] = None,
    entity_type: Optional[str] = None,
    entity_id: Optional[int] = None,
    description: Optional[str] = None,
    request: Optional[Request] = None,
):
    db: Session = SessionLocal()

    try:
        ip_address = get_client_ip(request) if request else None

        log = AuditLog(
            user_id=user_id,
            action=action.upper(),
            entity_type=entity_type,
            entity_id=entity_id,
            description=description,
            ip_address=ip_address,
        )

        db.add(log)
        db.commit()

    except Exception:
        db.rollback()

    finally:
        db.close()
