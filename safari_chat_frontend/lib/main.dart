import 'package:flutter/material.dart';
import 'pages/landing_page.dart';

void main() {
  runApp(SafariChatApp());
}

class SafariChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safari Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LandingPage(),
    );
  }
}
