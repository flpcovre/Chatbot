import 'dart:io';
import 'package:chatbot/model/SharedPrefs.dart';
import 'package:chatbot/model/dao/DataBase.dart';
import 'package:chatbot/model/dao/MySql.dart';
import 'package:chatbot/view/Login.dart';
import 'package:chatbot/view/UserRegister.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/view/Chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  MySql mySql = MySql();
  await DataBase.init(mySql);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatBot Example',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const UserRegister(),
        '/chat': (context) => const Chat()
      },
    );
  }
}