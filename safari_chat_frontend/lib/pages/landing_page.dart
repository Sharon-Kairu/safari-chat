import 'package:flutter/material.dart';
import 'chat_page.dart';

class LandingPage extends StatelessWidget {
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
                  borderRadius: BorderRadius.circular(12),
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


      backgroundColor: Colors.white,
      body: Stack(
        children:[
          Opacity(
            opacity: 0.15, // Adjust this for more or less transparency
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/flag1.jpg'), // your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Center(
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Safari Chat!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),

                Text(
                  "Your personalized AI guide for exploring Kenya’s top wildlife destinations",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red
                  ),

                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                      'Start Chat',
                      style: TextStyle(
                          fontSize: 18,
                        color: Colors.green
                      )),
                ),
              ],
            ),
                    ),
          ),]
      ),
    );
  }
}
