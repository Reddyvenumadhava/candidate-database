from fastapi import UploadFile, File
import pdfplumber
import re

@app.post("/parse-resume")
async def parse_resume(file: UploadFile = File(...)):
    text = ""

    # Read PDF
    with pdfplumber.open(file.file) as pdf:
        for page in pdf.pages:
            text += page.extract_text() or ""

    # Extract email
    email = re.findall(r"\S+@\S+", text)
    email = email[0] if email else "Not found"

    return {
        "email": email,
        "text": text[:500]
    }
