import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for formatting timestamps

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Straw'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                reverse: true, // Populate the list starting from the bottom
                itemBuilder: (context, index) {
                  final message = items[index];
                  return ListTile(
                    title: Text(message.text),
                    subtitle: Text(
                      '${message.username} • ${DateFormat('hh:mm a').format(message.timestamp)}',
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter a message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      setState(() {
                        // Add the message to the list
                        items.insert(
                          0,
                          Message(
                            text: _controller.text,
                            timestamp: DateTime.now(),
                            username:
                                'Current User', // Replace with actual username
                          ),
                        );
                        // Clear the text field
                        _controller.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Message {
  final String text;
  final DateTime timestamp;
  final String username;

  Message({
    required this.text,
    required this.timestamp,
    required this.username,
  });
}
