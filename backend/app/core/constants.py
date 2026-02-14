class BookingStatus:
    REQUESTED = "REQUESTED"
    APPROVED = "APPROVED"
    REJECTED = "REJECTED"
    ASSIGNED = "ASSIGNED"


ALLOWED_TRANSITIONS = {
    BookingStatus.REQUESTED: [
        BookingStatus.APPROVED,
        BookingStatus.REJECTED,
    ],
    BookingStatus.APPROVED: [
        BookingStatus.ASSIGNED,
    ],
    BookingStatus.REJECTED: [],
    BookingStatus.ASSIGNED: [],
}
