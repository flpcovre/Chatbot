import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chatbot/model/Api.dart';

class ChatAPI {
  String? _thread;
  final String _assistantId = 'asst_azoqVHr0SVa3oOmA9owDoySB';
  final _requestApi = const Api(headers: <String, String>{
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer sk-proj-pICEJlRPLEArq500MaLRT3BlbkFJLbweO7VcmKDT7PrwApp7',
                                'OpenAI-Beta': 'assistants=v2'
                              });

  Future<http.Response> createThread() async {
    final createThread = await _requestApi.post(url: 'https://api.openai.com/v1/threads');
    _thread = json.decode(createThread.body)['id'];
    return createThread;
  }

  Future<http.Response> createMessage({required message}) async {
    return await _requestApi.post(
       url: 'https://api.openai.com/v1/threads/$_thread/messages',
       body: <String, String>{
        'role': 'user',
        'content': '$message'
       }
    );
  }

  Future<http.Response> createRun() async {
    return await _requestApi.post(
        url: 'https://api.openai.com/v1/threads/$_thread/runs',
        body: <String, String>{
          'assistant_id': _assistantId,
          'instructions': 'Você é um Chatbot pessoal, responda com respostas claras e objetivas.'
        }
    );
  }

  Future<String?> assistantResponse() async {
    String? role = 'user';
    String? messageResponse;

    while (role == 'user') {
      final messages = await _requestApi.get(url: 'https://api.openai.com/v1/threads/$_thread/messages');

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