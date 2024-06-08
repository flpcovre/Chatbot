import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chatbot/model/Openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatAPI extends Openai {
  String? _thread;

  ChatAPI({required super.apiInterface, required super.headers, super.baseUri});

  Future<http.Response> createThread() async {
    final createThread = await getRequest().post(url: '/threads');
    _thread = json.decode(createThread.body)['id'];
    return createThread;
  }

  Future<http.Response> createMessage({required message}) async {
    return await getRequest().post(
       url: '/threads/$_thread/messages',
       body: <String, String>{
        'role': 'user',
        'content': '$message'
       }
    );
  }

  Future<http.Response> createRun() async {
    return await getRequest().post(
        url: '/threads/$_thread/runs',
        body: <String, String>{
          'assistant_id': const String.fromEnvironment('ASSINTANT_ID'),
          'instructions': 'Você é um Chatbot pessoal, responda com respostas claras e objetivas.'
        }
    );
  }

  Future<String?> assistantResponse() async {
    String? role = 'user';
    String? messageResponse;

    while (role == 'user') {
      final messages = await getRequest().get(url: '/threads/$_thread/messages');

      role = json.decode(messages.body)['data'][0]['role'];
      if (role == 'assistant') {
        messageResponse = json.decode(messages.body)['data'][0]['content'][0]['text']['value'];
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
    }

    return messageResponse;
  }

}