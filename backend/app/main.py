from fastapi import FastAPI

from app.core.config import settings
from app.core.logging import setup_logging
from app.api import auth
from app.db.base_class import *  # register models



def create_app() -> FastAPI:
    """
    Application factory.
    Keeps startup logic clean and testable.
    """
    setup_logging()

    app = FastAPI(
        title=settings.APP_NAME,
        docs_url="/docs" if settings.ENV == "development" else None,
        redoc_url="/redoc" if settings.ENV == "development" else None,
    )

    # Register routers
    app.include_router(auth.router, prefix="/api")


    return app


app = create_app()
