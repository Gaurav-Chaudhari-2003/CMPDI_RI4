from fastapi import FastAPI
from app.core.config import settings
from app.core.logging import setup_logging
from app.api.health import router as health_router

setup_logging()

app = FastAPI(
    title=settings.APP_NAME,
    debug=settings.DEBUG,
)

app.include_router(health_router, prefix="/api")
