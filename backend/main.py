from fastapi import UploadFile, File
import pdfplumber
import re

@app.post("/parse-resume")
async def parse_resume(file: UploadFile = File(...)):
    text = ""

    with pdfplumber.open(file.file) as pdf:
        for page in pdf.pages:
            text += page.extract_text() or ""

    # -------- EXTRACT DATA --------

    # Email
    email = re.findall(r"\S+@\S+", text)
    email = email[0] if email else "Not found"

    # Phone
    phone = re.findall(r"\+?\d[\d\s-]{8,}", text)
    phone = phone[0] if phone else "Not found"

    # Name (simple logic → first line)
    name = text.split("\n")[0]

    # Skills (basic matching)
    skills_list = ["python", "java", "sql", "c++", "react"]
    found_skills = [skill for skill in skills_list if skill.lower() in text.lower()]

    return {
        "name": name,
        "email": email,
        "phone": phone,
        "skills": found_skills,
        "text": text[:500]
    }
