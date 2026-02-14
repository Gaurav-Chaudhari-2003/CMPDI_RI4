from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    DateTime,
    ForeignKey,
    Enum,
    Index
)
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship

from app.db.base import Base
from app.db.enums.ftms_enums import BookingStatus


class Booking(Base):
    __tablename__ = "bookings"

    id = Column(Integer, primary_key=True, index=True)

    requester_id = Column(
        String,
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )

    purpose = Column(Text, nullable=False)

    start_datetime = Column(DateTime(timezone=True), nullable=False, index=True)
    end_datetime = Column(DateTime(timezone=True), nullable=False, index=True)

    pickup_location = Column(String(255), nullable=False)
    drop_location = Column(String(255), nullable=False)

    # User preferred vehicle
    requested_vehicle_id = Column(
        Integer,
        ForeignKey("vehicles.id", ondelete="SET NULL"),
        nullable=True
    )

    # Final assigned vehicle
    assigned_vehicle_id = Column(
        Integer,
        ForeignKey("vehicles.id", ondelete="SET NULL"),
        nullable=True
    )

    # Assigned driver
    assigned_driver_id = Column(
        Integer,
        ForeignKey("drivers.id", ondelete="SET NULL"),
        nullable=True
    )

    status = Column(
        Enum(BookingStatus, name="booking_status_enum"),
        default=BookingStatus.REQUESTED,
        nullable=False,
        index=True
    )

    approved_by = Column(
        String,
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True
    )

    remarks = Column(Text, nullable=True)

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )

    # Relationships
    requester = relationship("User", foreign_keys=[requester_id])

    approver = relationship("User", foreign_keys=[approved_by])

    requested_vehicle = relationship(
        "Vehicle",
        foreign_keys=[requested_vehicle_id],
        back_populates="bookings_requested"
    )

    assigned_vehicle = relationship(
        "Vehicle",
        foreign_keys=[assigned_vehicle_id],
        back_populates="bookings_assigned"
    )

    assigned_driver = relationship(
        "Driver",
        foreign_keys=[assigned_driver_id],
        back_populates="bookings_assigned"
    )

    status_history = relationship(
        "BookingStatusHistory",
        back_populates="booking",
        cascade="all, delete-orphan"
    )


# Composite index for scheduling queries
Index(
    "idx_booking_time_range",
    Booking.start_datetime,
    Booking.end_datetime
)
