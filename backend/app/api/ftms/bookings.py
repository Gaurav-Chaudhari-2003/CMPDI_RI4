from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.services.ftms.booking_service import BookingService

from app.schemas.ftms.booking_schemas import BookingCreate

router = APIRouter(
    prefix="/api/ftms/bookings",
    tags=["FTMS Bookings"]
)



@router.post("/")
def create_booking(
    payload: BookingCreate,
    db: Session = Depends(get_db)
):
    service = BookingService(db)

    booking = service.create_booking(
        user_id=payload.requester_id,
        booking_data=payload
    )

    return booking


@router.post("/{booking_id}/approve")
def approve_booking(
    booking_id: int,
    approver_id: str,
    db: Session = Depends(get_db)
):
    service = BookingService(db)

    return service.approve_booking(booking_id, approver_id)


@router.post("/{booking_id}/reject")
def reject_booking(
    booking_id: int,
    approver_id: str,
    db: Session = Depends(get_db)
):
    service = BookingService(db)

    return service.reject_booking(booking_id, approver_id)


@router.post("/{booking_id}/assign")
def assign_resources(
    booking_id: int,
    vehicle_id: int,
    driver_id: int,
    user_id: str,
    db: Session = Depends(get_db)
):
    service = BookingService(db)

    return service.assign_resources(
        booking_id,
        vehicle_id,
        driver_id,
        user_id
    )
