import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketLocal extends StatefulWidget {
  const WebSocketLocal({super.key});

  @override
  _WebSocketLocalState createState() => _WebSocketLocalState();
}

class _WebSocketLocalState extends State<WebSocketLocal> {
  TextEditingController controller = TextEditingController();
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.0.115:6001/app/classicit07?protocol=7&client=js&version=4.3.1'),
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
