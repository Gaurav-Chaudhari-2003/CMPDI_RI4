from fastapi import APIRouter, Depends, Request

from app.core.permissions import require_permission
from app.core.audit_decorator import audit

router = APIRouter(prefix="/api/test", tags=["Permissions"])


@router.post("/create-booking")
@audit("FTMS_BOOKING_CREATED", "booking")
def create_booking(
    request: Request,
    current_user=Depends(require_permission("FTMS_CREATE_BOOKING")),
):
    return {"id": 123, "message": "Booking created"}
