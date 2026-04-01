from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"message": "API working"}

@app.get("/users")
def get_users():
    return {"users": ["Venu", "Ravi", "Kiran"]}

@app.post("/add-user")
def add_user(name: str):
    return {"message": f"{name} added successfully"}
