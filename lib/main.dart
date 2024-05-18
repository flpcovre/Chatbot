import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ChatBot Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatFactory> _messages = [
    const ChatFactory(message: 'Olá, como posso te ajudar?', isUser: false)
  ];
  final ScrollController _scrollController = ScrollController();

  AppBar header() {
    return AppBar(
      title: const Text('ChatBot Example'),
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
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
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


  void _sendMessage({required bool isUser}) {
    if (_textController.text.trim() == '') return;

    setState(() {
      _messages.add(ChatFactory(
        message: _textController.text,
        isUser: isUser,
      ));

      _textController.clear();
    });

    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    if (true) {
      setState(() {
        _messages.add(const ChatFactory(
          message: 'Bot Message',
          isUser: false,
        ));
      });
    }
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

class ChatFactory extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatFactory({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isUser)
          Container(
            margin: const EdgeInsets.only(top: 45, left: 5),
            child: const Icon(
              Icons.account_circle,
              size: 20,
            ),
          ),
        Flexible(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: isUser ? Colors.blue[100] : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
                bottomLeft: isUser
                    ? const Radius.circular(15.0)
                    : const Radius.circular(0),
                bottomRight: isUser
                    ? const Radius.circular(0)
                    : const Radius.circular(15.0),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        if (isUser)
          Container(
            margin: const EdgeInsets.only(top: 45, right: 5),
            child: const Icon(Icons.account_circle, size: 20),
          ),
      ],
    );
  }
}
