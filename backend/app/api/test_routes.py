from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from datetime import datetime, timedelta

from app.db.session import get_db
from app.services.ftms.booking_service import BookingService

router = APIRouter(prefix="/test", tags=["TEST"])


class DummyBookingData:
    def __init__(self):
        self.purpose = "Official Visit"
        self.start_time = datetime.utcnow() + timedelta(hours=2)
        self.end_time = datetime.utcnow() + timedelta(hours=6)
        self.pickup_location = "CMPDI Office"
        self.drop_location = "Nagpur Airport"


@router.post("/create-booking")
def test_create_booking(db: Session = Depends(get_db)):
    service = BookingService(db)

    booking = service.create_booking(
        user_id="11111111-1111-1111-1111-111111111111",
        booking_data=DummyBookingData()
    )

    return booking


@router.post("/approve/{booking_id}")
def test_approve_booking(booking_id: int, db: Session = Depends(get_db)):
    service = BookingService(db)

    return service.approve_booking(
        booking_id=booking_id,
        approver_id="11111111-1111-1111-1111-111111111111"
    )


@router.post("/reject/{booking_id}")
def test_reject_booking(booking_id: int, db: Session = Depends(get_db)):
    service = BookingService(db)

    return service.reject_booking(
        booking_id=booking_id,
        approver_id="11111111-1111-1111-1111-111111111111"
    )


@router.post("/assign/{booking_id}")
def test_assign_resources(booking_id: int, db: Session = Depends(get_db)):
    service = BookingService(db)

    return service.assign_resources(
        booking_id=booking_id,
        vehicle_id=1,     # use existing vehicle id
        driver_id=1,      # use existing driver id
        user_id="11111111-1111-1111-1111-111111111111"
    )
