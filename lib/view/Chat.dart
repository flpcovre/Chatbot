import 'package:flutter/material.dart';
import 'package:chatbot/controller/ChatController.dart';
import 'package:chatbot/factories/ChatFactory.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatFactory> _messages = [
    const ChatFactory(message: 'Olá, como posso te ajudar?', isUser: false)
  ];
  final ScrollController _scrollController = ScrollController();
  final ChatController _chatController = ChatController();

  AppBar header() {
    return AppBar(
      title: const Text('Personal ChatBot'),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      reverse: true,
      controller: _scrollController,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: _messages,
        ),
      ),
    );
  }

  Widget footer() {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(15.0),
        height: 80,
        child: TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Digite algo',
              suffixIcon: IconButton(
                onPressed: () {
                  _sendMessage(isUser: true);
                },
                icon: const Icon(Icons.send),
              ),
              border: const OutlineInputBorder(
                  borderRadius:  BorderRadius.all(Radius.circular(15.0))
              ),
            )
        ),
      ),
    );
  }

  void _sendMessage({required bool isUser}) async {
    if (_textController.text.trim() == '') return;

    String message = _textController.text;
    setState(() {
      _messages.add(ChatFactory(
        message: message,
        isUser: isUser,
      ));
      _textController.clear();
    });

    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    String? response = await _chatController.sendMessage(message: message);
    print(response);
    setState(() {
      _messages.add(ChatFactory(
        message: '$response',
        isUser: false,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: body(),
      bottomNavigationBar: footer(),
    );
  }
}