# app.py
from flask import Flask, request, jsonify
from retriever import Retriever
from gemma_runner import ask_gemma

app = Flask(__name__)
retriever = Retriever("kenya_facts.json")

@app.route('/ask', methods=['POST'])
def ask():
    data = request.json
    user_question = data.get("question")
    
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

if __name__ == '__main__':
    app.run(debug=True)
