from fastapi import FastAPI

# Register models
from app.db.base_class import *

# Routers
from app.api import auth
from app.api import test_permissions
from app.api.test_routes import router as test_router
from app.api.ftms.bookings import router as ftms_booking_router


app = FastAPI()


# Core routers
app.include_router(auth.router)
app.include_router(test_permissions.router)

# FTMS routers
app.include_router(ftms_booking_router)

# Test router (temporary — will be removed later)
app.include_router(test_router)


@app.get("/")
def root():
    return {"status": "API running"}
