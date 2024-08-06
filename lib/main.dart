import 'package:flutter/material.dart';
import 'package:web_scoket_tester/screen/websocket_local.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebSocketLocal(),
    );
  }
}
