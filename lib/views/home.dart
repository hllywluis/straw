import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for formatting timestamps
import '../classes/message.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> items = [];
  final String channelName =
      '#libera'; // TODO: Replace with actual channel name

  void _sendMessage() {
    setState(() {
      // Add the message to the list
      items.insert(
        0,
        Message(
          text: _controller.text,
          timestamp: DateTime.now(),
          username: 'hllywluis', // TODO: Replace with actual username
        ),
      );
      // Clear the text field
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(channelName),
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
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        // Trigger a rebuild to update the decoration
                        setState(() {});
                      },
                      child: Builder(
                        builder: (context) {
                          final hasFocus = Focus.of(context).hasFocus;
                          return Container(
                            padding: const EdgeInsets.all(
                                4.0), // Add padding to create space for the shadow
                            decoration: BoxDecoration(
                              boxShadow: hasFocus
                                  ? [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.25),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Message in $channelName',
                                border: const OutlineInputBorder(),
                                filled: true, // Ensure the background is filled
                                fillColor:
                                    Colors.white, // Set the background color
                              ),
                              onSubmitted: (value) {
                                _sendMessage();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
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
