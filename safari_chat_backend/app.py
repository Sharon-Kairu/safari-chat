from flask import Flask, request, jsonify
from retriever import Retriever
from gemma_runner import ask_gemma

app = Flask(__name__)
retriever = Retriever("kenya_facts.json")

@app.route('/')
def home():
    return "Safari Chat Backend is running"

@app.route("/ping", methods=["GET"])
def ping():
    return "Backend is working!", 200

@app.route('/ask', methods=['POST'])
def ask():
    try:
        data = request.json
        user_question = data.get("question")

        if not user_question:
            return jsonify({"error": "Question is required"}), 400

        # RAG: retrieve relevant facts
        context_chunks = retriever.retrieve(user_question)
        context = "\n".join(context_chunks)

        # Construct prompt
        prompt = f"""You are a helpful bot for exploring Kenya.
Use the following context to answer the user's question.

Context:
{context}

User: {user_question}
Bot:"""

        # Send to Gemma
        answer = ask_gemma(prompt)

        return jsonify({"answer": answer})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route("/chat", methods=["POST"])
def chat():
    try:
        data = request.get_json()
        user_message = data.get("message", "")

        if not user_message:
            return jsonify({"error": "Message is required"}), 400

        # RAG also applied in chat
        context_chunks = retriever.retrieve(user_message)
        context = "\n".join(context_chunks)

        prompt = f"""You are a helpful bot for chatting about Kenya's attractions and general facts.
Use the following context to respond helpfully.

Context:
{context}

User: {user_message}
Bot:"""

        response = ask_gemma(prompt)

        return jsonify({"reply": response})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
