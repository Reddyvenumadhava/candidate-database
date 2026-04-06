from fastapi import FastAPI

app = FastAPI()
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

users = ["Venu", "Ravi", "Kiran"]

@app.get("/users")
def get_users():
    return {"users": users}

@app.post("/add-user")
def add_user(name: str):
    users.append(name)
    return {"message": f"{name} added successfully"}
