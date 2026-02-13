# test_db.py
from app.db.session import engine

print(engine.connect())
