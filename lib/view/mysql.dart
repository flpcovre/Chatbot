import 'package:flutter/material.dart';
import 'package:chatbot/controller/mysqlcontroller.dart';

class Mysql extends StatefulWidget {
  const Mysql({super.key});

  @override
  State<Mysql> createState() => _MysqlState();
}

class _MysqlState extends State<Mysql> {

  MysqlController mysqlController = MysqlController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MySql Testing'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  await mysqlController.connect();
                },
                child: Text('Clique Aqui')
            )
          ],
        ),
      ),
    );
  }
}
