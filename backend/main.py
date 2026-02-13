from fastapi import FastAPI

from app.core.config import settings
from app.api import auth


def create_app() -> FastAPI:

    app = FastAPI(
        title=settings.APP_NAME,
        docs_url="/docs" if settings.ENV == "development" else None,
        redoc_url="/redoc" if settings.ENV == "development" else None,
    )

    # Register routers
    app.include_router(auth.router, prefix="/api")

    return app


app = create_app()
