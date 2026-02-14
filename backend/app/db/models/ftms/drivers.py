from sqlalchemy import Column, Integer, String, DateTime, Enum
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship

from app.db.base import Base
from app.db.enums.ftms_enums import DriverStatus


class Driver(Base):
    __tablename__ = "drivers"

    id = Column(Integer, primary_key=True, index=True)

    name = Column(String(120), nullable=False)
    phone = Column(String(20), nullable=False)

    license_number = Column(String(100), unique=True, nullable=False, index=True)

    status = Column(
        Enum(DriverStatus, name="driver_status_enum"),
        default=DriverStatus.ACTIVE,
        nullable=False,
        index=True
    )

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )

    # Relationships
    vehicles_default = relationship(
        "Vehicle",
        back_populates="default_driver"
    )

    bookings_assigned = relationship(
        "Booking",
        back_populates="assigned_driver",
        foreign_keys="Booking.assigned_driver_id"
    )
