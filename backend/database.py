from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# 🔴 CHANGE THESE VALUES
USERNAME = "your_username"
PASSWORD = "your_password"
SERVER = "candidatesql.database.windows.net"
DATABASE = "candidate"

DATABASE_URL = f"mssql+pyodbc://{USERNAME}:{PASSWORD}@{SERVER}/{DATABASE}?driver=ODBC+Driver+17+for+SQL+Server"

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
