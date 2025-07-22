import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child:Text(
            'Welcome to Safari Chat',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
          ),

        ),
      ),

    );
}
