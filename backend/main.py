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


# DELETE USER
@app.delete("/delete-user")
def delete_user(name: str):
    if name in users:
        users.remove(name)
        return {"message": f"{name} deleted"}
    return {"message": "User not found"}


# UPDATE USER
@app.put("/update-user")
def update_user(old_name: str, new_name: str):
    if old_name in users:
        index = users.index(old_name)
        users[index] = new_name
        return {"message": f"{old_name} updated to {new_name}"}
    return {"message": "User not found"}
