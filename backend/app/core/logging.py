import logging
import sys

from backend.app.core.config import settings


def setup_logging() -> None:
    """
    Configure application-wide logging.
    Environment-aware.
    """

    log_level = logging.DEBUG if settings.ENV == "development" else logging.INFO

    logging.basicConfig(
        level=log_level,
        format="%(asctime)s | %(levelname)s | %(name)s | %(message)s",
        handlers=[
            logging.StreamHandler(sys.stdout)
        ],
    )

    # Reduce noisy loggers (optional but recommended)
    logging.getLogger("uvicorn.access").setLevel(logging.WARNING)
