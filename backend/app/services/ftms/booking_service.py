from sqlalchemy.orm import Session
from fastapi import HTTPException, status

from datetime import datetime


from app.core.constants import BookingStatus
from app.db.models.ftms.bookings import Booking
from app.db.models.ftms.booking_history import BookingStatusHistory


class BookingService:


    def __init__(self, db: Session):
        self.db = db


    # Rule 1
    def create_booking(self, user_id: str, booking_data):

        new_booking = Booking(
            requester_id=user_id,   # FIXED

            purpose=booking_data.purpose,

            start_datetime=booking_data.start_time,   # FIXED
            end_datetime=booking_data.end_time,       # FIXED

            pickup_location=booking_data.pickup_location,
            drop_location=booking_data.drop_location,

            status=BookingStatus.REQUESTED,  # MUST be enum

            approved_by=None,
            assigned_vehicle_id=None,
            assigned_driver_id=None
        )

        self.db.add(new_booking)
        self.db.flush()

        history = BookingStatusHistory(
            booking_id=new_booking.id,
            old_status=BookingStatus.REQUESTED,
            new_status=BookingStatus.REQUESTED,
            changed_by=user_id
        )

        self.db.add(history)
        self.db.commit()
        self.db.refresh(new_booking)

        return new_booking


    # Rule 2
    def approve_booking(self, booking_id: int, approver_id: str):

        booking = self.db.query(Booking).filter(Booking.id == booking_id).first()

        if not booking:
            raise HTTPException(status_code=404, detail="Booking not found")

        if booking.status != BookingStatus.REQUESTED:
            raise HTTPException(
                status_code=400,
                detail="Only REQUESTED bookings can be approved"
            )

        old_status = booking.status

        booking.status = BookingStatus.APPROVED
        booking.approved_by = approver_id

        history = BookingStatusHistory(
            booking_id=booking.id,
            old_status=old_status,
            new_status=BookingStatus.APPROVED,
            changed_by=approver_id
        )

        self.db.add(history)
        self.db.commit()
        self.db.refresh(booking)

        return booking

    def reject_booking(self, booking_id: int, approver_id: str):

        booking = self.db.query(Booking).filter(Booking.id == booking_id).first()

        if not booking:
            raise HTTPException(status_code=404, detail="Booking not found")

        if booking.status != BookingStatus.REQUESTED:
            raise HTTPException(
                status_code=400,
                detail="Only REQUESTED bookings can be rejected"
            )

        old_status = booking.status

        booking.status = BookingStatus.REJECTED

        history = BookingStatusHistory(
            booking_id=booking.id,
            old_status=old_status,
            new_status=BookingStatus.REJECTED,
            changed_by=approver_id
        )

        self.db.add(history)
        self.db.commit()
        self.db.refresh(booking)

        return booking


    # Rule 3
    def assign_resources(
            self,
            booking_id: int,
            vehicle_id: int,
            driver_id: int,
            user_id: str
    ):

        booking = self.db.query(Booking).filter(Booking.id == booking_id).first()

        if not booking:
            raise HTTPException(status_code=404, detail="Booking not found")

        if booking.status != BookingStatus.APPROVED:
            raise HTTPException(
                status_code=400,
                detail="Only APPROVED bookings can be assigned"
            )

        old_status = booking.status

        booking.assigned_vehicle_id = vehicle_id
        booking.assigned_driver_id = driver_id
        booking.status = BookingStatus.ASSIGNED

        history = BookingStatusHistory(
            booking_id=booking.id,
            old_status=old_status,
            new_status=BookingStatus.ASSIGNED,
            changed_by=user_id
        )

        self.db.add(history)
        self.db.commit()
        self.db.refresh(booking)

        return booking

