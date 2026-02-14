from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Enum
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship

from app.db.base import Base
from app.db.enums.ftms_enums import VehicleStatus


class Vehicle(Base):
    __tablename__ = "vehicles"

    id = Column(Integer, primary_key=True, index=True)

    vehicle_number = Column(String(50), unique=True, nullable=False, index=True)
    vehicle_type = Column(String(50), nullable=False)
    capacity = Column(Integer, nullable=False)

    status = Column(
        Enum(VehicleStatus, name="vehicle_status_enum"),
        default=VehicleStatus.ACTIVE,
        nullable=False,
        index=True
    )

    default_driver_id = Column(
        Integer,
        ForeignKey("drivers.id", ondelete="SET NULL"),
        nullable=True
    )

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )

    # Relationships
    default_driver = relationship("Driver", foreign_keys=[default_driver_id])
    bookings_assigned = relationship(
        "Booking",
        back_populates="assigned_vehicle",
        foreign_keys="Booking.assigned_vehicle_id"
    )

    bookings_requested = relationship(
        "Booking",
        back_populates="requested_vehicle",
        foreign_keys="Booking.requested_vehicle_id"
    )
