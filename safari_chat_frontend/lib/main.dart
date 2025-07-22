import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PingPage(),
    );
  }
}

class PingPage extends StatefulWidget {
  @override
  _PingPageState createState() => _PingPageState();
}

class _PingPageState extends State<PingPage> {
  String response = "Press button to test backend";

  void testBackend() async {
    try {
      String res = await ApiService.pingServer();
      setState(() {
        response = res;
      });
    } catch (e) {
      setState(() {
        response = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Backend Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(response),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: testBackend,
              child: Text("Test Backend"),
            ),
          ],
        ),
      ),
    );
  }
}
