import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chatbot/model/ChatAPI.dart';

class ChatController {
  final ChatAPI chatAPI = ChatAPI();

  Future<String?> sendMessage({required String message}) async {
    await chatAPI.createThread();
    await chatAPI.createMessage(message: message);
    await chatAPI.createRun();
    return await chatAPI.assistantResponse();
  }
}