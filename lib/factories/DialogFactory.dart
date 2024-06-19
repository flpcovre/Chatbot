import 'package:flutter/material.dart';

class DialogFactory {
  static Future<void> show(
      BuildContext context, {
        required String title,
        required String content,
        required VoidCallback onOkPressed,
      }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                onOkPressed();
              },
            ),
          ],
        );
      },
    );
  }
}