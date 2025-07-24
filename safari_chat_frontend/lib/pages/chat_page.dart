// chat_page.dart
import 'package:flutter/material.dart';
import 'package:safari_chat/services/api_service.dart'; // ✅ Import the API service

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'user', 'text': text});
      });
      _controller.clear();

      try {
        final botReply = await ApiService.sendMessage(text);
        setState(() {
          _messages.add({'sender': 'bot', 'text': botReply});
        });
      } catch (e) {
        setState(() {
          _messages.add({'sender': 'bot', 'text': 'Error: $e'});
        });
      }
    }
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(
           maxWidth: 250),
        decoration: BoxDecoration(
          color: isUser ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(message['text'] ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: AssetImage('assets/appbar.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Overlay text
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Safari\n',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                      TextSpan(
                        text: ' Chat',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(

        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),

              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),

            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type your question",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _sendMessage,
                      icon: Icon(Icons.send, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),

          )
        ],
      ),
    );
  }
}
