from fastapi import APIRouter
import logging

from backend.app.core.response import success_response
from backend.app.core.config import settings

router = APIRouter()
logger = logging.getLogger(__name__)


@router.get("/health", tags=["Health"])
def health_check():
    logger.info("Health check endpoint called")

    return success_response(
        data={
            "status": "UP",
            "service": settings.APP_NAME,
        },
        message="Service healthy",
    )
