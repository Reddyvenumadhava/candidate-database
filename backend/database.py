import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# ✅ Get values from Azure Environment Variables
DB_SERVER = os.getenv("DB_SERVER")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

# ✅ Correct connection string
DATABASE_URL = f"mssql+pyodbc://{DB_USER}:{DB_PASSWORD}@{DB_SERVER}/{DB_NAME}?driver=ODBC+Driver+17+for+SQL+Server"

# ✅ Create engine
engine = create_engine(DATABASE_URL)

# ✅ Session
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# ✅ Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
