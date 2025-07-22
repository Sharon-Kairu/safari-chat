# gemma_runner.py
import requests

def ask_gemma(prompt):
    response = requests.post(
        "http://localhost:11434/api/generate",
        json={
            "model": "gemma",
            "prompt": prompt,
            "stream": False
        }
    )
    return response.json()['response']
