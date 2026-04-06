from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
import pdfplumber
import re

app = FastAPI()

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# TEST ROUTE (VERY IMPORTANT)
@app.get("/")
def home():
    return {"message": "API working"}

# USERS
users = ["Venu", "Ravi", "Kiran"]

@app.get("/users")
def get_users():
    return {"users": users}

@app.post("/add-user")
def add_user(name: str):
    users.append(name)
    return {"message": f"{name} added"}

@app.put("/update-user")
def update_user(old_name: str, new_name: str):
    if old_name in users:
        users[users.index(old_name)] = new_name
        return {"message": "updated"}
    return {"message": "not found"}

@app.delete("/delete-user")
def delete_user(name: str):
    if name in users:
        users.remove(name)
        return {"message": "deleted"}
    return {"message": "not found"}

# RESUME PARSER
@app.post("/parse-resume")
async def parse_resume(file: UploadFile = File(...)):
    try:
        text = ""

        with pdfplumber.open(file.file) as pdf:
            for page in pdf.pages:
                text += page.extract_text() or ""

        email = re.findall(r"\S+@\S+", text)
        phone = re.findall(r"\+?\d[\d\s-]{8,}", text)

        return {
            "name": text.split("\n")[0] if text else "Not found",
            "email": email[0] if email else "Not found",
            "phone": phone[0] if phone else "Not found",
            "skills": []
        }

    except Exception as e:
        return {"error": str(e)}
