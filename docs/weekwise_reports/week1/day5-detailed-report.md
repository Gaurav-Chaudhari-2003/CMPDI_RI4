# Day 5 Detailed Report --- Enterprise Audit Logging System

## 1. Overview

Day 5 focused on implementing a complete enterprise‑grade audit logging
system that records authentication events, authorization failures, and
business actions automatically.

------------------------------------------------------------------------

## 2. Architecture

API → RBAC Layer → Audit Service → Audit DB

------------------------------------------------------------------------

## 3. Audit Table Model

File: app/db/models/audit_log.py

``` python
class AuditLog(Base):
    __tablename__ = "audit_logs"
    id = Column(Integer, primary_key=True)
    user_id = Column(String)
    action = Column(String(100))
    entity_type = Column(String(100))
    entity_id = Column(Integer)
    description = Column(Text)
    ip_address = Column(String(50))
    created_at = Column(DateTime, default=func.now())
```

------------------------------------------------------------------------

## 4. Audit Service

File: app/core/audit.py

``` python
def log_action(action, user_id=None, entity_type=None,
               entity_id=None, description=None, request=None):
    db = SessionLocal()
    log = AuditLog(...)
    db.add(log)
    db.commit()
```

------------------------------------------------------------------------

## 5. Auth Logging

LOGIN_SUCCESS / LOGIN_FAILED recorded in auth.py

------------------------------------------------------------------------

## 6. RBAC Logging

PERMISSION_DENIED recorded in permissions.py

------------------------------------------------------------------------

## 7. Audit Decorator

``` python
@audit("FTMS_BOOKING_CREATED", "booking")
def create_booking():
    pass
```

------------------------------------------------------------------------

## 8. Outcome

System now provides enterprise accountability.
