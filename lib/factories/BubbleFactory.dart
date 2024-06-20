import 'package:flutter/material.dart';

class BubbleFactory extends StatelessWidget {
  final String message;
  final String type;

  const BubbleFactory({super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      type == 'U' ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: type == 'U' ? Colors.blue[100] : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
                bottomLeft: type == 'U'
                    ? const Radius.circular(15.0)
                    : const Radius.circular(0),
                bottomRight: type == 'U'
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
            child: (type == 'A' || type == 'U')
            ? Text(
              message,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
              ),
            )
            : Image.asset(
                'lib/assets/img/loading.gif',
                width: 23,
                height: 23,
            )
          ),
        ),
      ],
    );
  }
}