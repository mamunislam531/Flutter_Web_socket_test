import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketTest extends StatefulWidget {
  const WebSocketTest({super.key});

  @override
  _WebSocketTestState createState() => _WebSocketTestState();
}

class _WebSocketTestState extends State<WebSocketTest> {
  TextEditingController controller = TextEditingController();
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                return Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(snapshot.hasData ? '${snapshot.data}' : ''));
              },
            ),
            const SizedBox(height: 100),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Send a message',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  channel.sink.add(controller.text);
                },
                child: const Text("Sent Req"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
