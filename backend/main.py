from fastapi import FastAPI
from database import engine

app = FastAPI()

@app.get("/")
def root():
    return {"message": "API is running"}

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/test-db")
def test_db():
    try:
        conn = engine.connect()
        conn.close()
        return {"message": "Database connected successfully"}
    except Exception as e:
        return {"error": str(e)}
