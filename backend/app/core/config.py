from pydantic_settings import BaseSettings
from pydantic import Field, ValidationError


class Settings(BaseSettings):
    # Required
    APP_NAME: str = Field(..., min_length=1)
    ENV: str = Field(..., pattern="^(development|staging|production)$")
    DATABASE_URL: str = Field(..., min_length=1)
    JWT_SECRET: str = Field(..., min_length=8)
    JWT_ALGORITHM: str = Field(..., min_length=1)

    model_config = SettingsConfigDict(
        env_file=".env",
        case_sensitive=True
    )


try:
    settings = Settings()
except ValidationError as e:
    # Fail fast at startup
    raise RuntimeError(f"Configuration error: {e}")
