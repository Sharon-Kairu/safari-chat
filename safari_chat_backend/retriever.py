# retriever.py
import json
from sentence_transformers import SentenceTransformer, util

class Retriever:
    def __init__(self, kb_path):
        self.model = SentenceTransformer('all-MiniLM-L6-v2')
        with open(kb_path, 'r') as f:
            self.knowledge_base = json.load(f)
        self.embeddings = [self.model.encode(entry['description'], convert_to_tensor=True) for entry in self.knowledge_base]


    def retrieve(self, query, top_k=2):
        query_embedding = self.model.encode(query, convert_to_tensor=True)
        hits = util.semantic_search(query_embedding, self.embeddings, top_k=top_k)[0]
        return [self.knowledge_base[hit['corpus_id']]['description'] for hit in hits]
