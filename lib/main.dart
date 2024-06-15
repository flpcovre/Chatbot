import 'dart:io';
import 'package:chatbot/model/dao/DataBase.dart';
import 'package:chatbot/model/dao/MySql.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/view/Chat.dart';

void main() async {
  MySql mySql = MySql();
  await DataBase.init(mySql);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ChatBot Example',
      home: Chat(),
    );
  }
}