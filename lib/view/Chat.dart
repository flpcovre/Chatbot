import 'package:chatbot/view/Chat.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/controller/ChatController.dart';
import 'package:chatbot/factories/BubbleFactory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatController _chatController = ChatController();
  late List<BubbleFactory> _messages = [];

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<void> loadMessages() async {
    final List<BubbleFactory> messages = await _chatController.listAllMessages();
    setState(() {
      _messages = messages;
    });
  }

  Widget navBar() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
              accountName: Text('Filipe'),
              accountEmail: Text('example@email.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                    child: Icon(Icons.person, size: 60),
                ),
              ),
          ),
          ListTile(
            leading: const Icon(Icons.restore_from_trash_outlined),
            title: const Text('Limpar Conversa'),
            onTap: () {
                setState(() {
                  _messages.clear();
                  _messages.add(
                      const BubbleFactory(message: 'Olá, como posso te ajudar?', type: 'A')
                  );
                });
                _chatController.clearChat();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('userId');
              Navigator.of(context).pushReplacementNamed('/login');
            },
          )
        ],
      ),
    );
  }

  AppBar header() {
    return AppBar(
      title: const Text(
        'Personal ChatBot',
        style: TextStyle(
          color: Colors.white
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.deepPurple,
      centerTitle: true,
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
    return Container(
      color: Colors.white,
      child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.all(10.0),
              height: 80,
              child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Digite algo',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _chatController.listAllMessages();
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
      ),
    );
  }

  void _sendMessage({required bool isUser}) async {
    if (_textController.text.trim() == '') return;

    String message = _textController.text;
    setState(() {
      _messages.add(BubbleFactory(
        message: message,
        type: 'U',
      ));
      _textController.clear();
    });

    await Future.delayed( const Duration(milliseconds: 500));

    setState(() {
      _messages.add(const BubbleFactory(message: '', type: 'T'));
    });

    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    String? response = await _chatController.sendMessage(message: message);
    print(response);

    _messages.removeLast();

    setState(() {
      _messages.add(BubbleFactory(
        message: '$response',
        type: 'A',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      drawer: navBar(),
      appBar: header(),
      body: body(),
      bottomNavigationBar: footer(),
    );
  }
}