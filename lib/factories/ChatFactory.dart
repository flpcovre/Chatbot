import 'package:flutter/material.dart';

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