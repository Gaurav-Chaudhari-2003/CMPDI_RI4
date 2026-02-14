from pydantic import BaseModel
from datetime import datetime


class BookingCreate(BaseModel):
    requester_id: str
    purpose: str
    start_time: datetime
    end_time: datetime
    pickup_location: str
    drop_location: str
