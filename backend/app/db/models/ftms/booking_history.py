from sqlalchemy import Column, Integer, DateTime, ForeignKey, Enum, String
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship

from app.db.base import Base
from app.db.enums.ftms_enums import BookingStatus


class BookingStatusHistory(Base):
    __tablename__ = "booking_status_history"

    id = Column(Integer, primary_key=True, index=True)

    booking_id = Column(
        Integer,
        ForeignKey("bookings.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )

    old_status = Column(
        Enum(BookingStatus, name="booking_status_enum"),
        nullable=False
    )

    new_status = Column(
        Enum(BookingStatus, name="booking_status_enum"),
        nullable=False
    )

    changed_by = Column(
        String,
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True
    )

    changed_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )

    # Relationships
    booking = relationship("Booking", back_populates="status_history")

    user = relationship("User", foreign_keys=[changed_by])
