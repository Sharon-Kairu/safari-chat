import requests

# Optional: Keep conversation memory (can remove if not needed)
conversation = []

def add_message(role, content):
    conversation.append({"role": role, "content": content})

def build_prompt():
    prompt = ""
    for msg in conversation:
        prefix = "User:" if msg["role"] == "user" else "Assistant:"
        prompt += f"{prefix} {msg['content']}\n"
    prompt += "Assistant:"
    return prompt

def ask_gemma(prompt):
    try:
        response = requests.post(
            "http://localhost:11434/api/generate",
            json={
                "model": "gemma:2b",
                "prompt": prompt,
                "stream": False
            }
        )

        if response.status_code != 200:
            return "[Error] No response from Gemma."

        reply = response.json().get("response", "[Error] Gemma gave no reply")
        return reply.strip()

    except Exception as e:
        return f"[Gemma Error] {str(e)}"
