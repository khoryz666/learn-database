import os
import sys
try:
    import PyPDF2
except ImportError:
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "PyPDF2"])
    import PyPDF2

def extract_text_from_pdf(pdf_path, txt_path):
    try:
        with open(pdf_path, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            text = ''
            for page in reader.pages:
                t = page.extract_text()
                if t:
                    text += t + '\n'
            with open(txt_path, 'w', encoding='utf-8') as out_file:
                out_file.write(text)
    except Exception as e:
        print(f"Error on {pdf_path}: {e}")

base_dir = r"c:\Users\2305662\Desktop\learn-database"
dirs = ["lecture_slides", "practical_slides"]
out_dir = os.path.join(base_dir, "extracted_texts")
os.makedirs(out_dir, exist_ok=True)

for d in dirs:
    d_path = os.path.join(base_dir, d)
    for f in os.listdir(d_path):
        if f.endswith(".pdf"):
            pdf_path = os.path.join(d_path, f)
            txt_path = os.path.join(out_dir, f"{d}_{f.replace('.pdf', '.txt')}")
            print(f"Extracting {f}...")
            extract_text_from_pdf(pdf_path, txt_path)

print("Extraction complete.")
