from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    APP_NAME: str = "Vehicle Booking API"
    ENV: str = "development"
    DEBUG: bool = True
    HOST: str = "0.0.0.0"
    PORT: int = 8000

    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()
