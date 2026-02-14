from fastapi import FastAPI

from app.api import auth
from app.api import test_permissions

from app.db.base_class import *  # register models


app = FastAPI()


app.include_router(auth.router)
app.include_router(test_permissions.router)


@app.get("/")
def root():
    return {"status": "API running"}
