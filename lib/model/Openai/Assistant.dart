import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chatbot/model/Openai/Openai.dart';

class Assistant extends Openai {
  String? _thread;
  String? _runId;
  String assistantId;

  Assistant({required super.apiInterface, required super.headers, super.baseUri, required this.assistantId});

  Future<dynamic> createThread({String threadId = ''}) async {
    if (threadId != '') {
      _thread = threadId;
      return _thread;
    }
    final createThread = await post(url: '/threads');
    _thread = await json.decode(createThread.body)['id'];
    return _thread;
  }

  Future<http.Response> createMessage({required message}) async {
    return await post(
        url: '/threads/$_thread/messages',
        body: <String, String>{
          'role': 'user',
          'content': '$message'
        }
    );
  }

  Future<http.Response> createRun() async {
    final createRun =  await post(
        url: '/threads/$_thread/runs',
        body: <String, String>{
          'assistant_id': assistantId,
          'instructions': 'Você é um Chatbot pessoal, responda com respostas claras e objetivas.'
        }
    );
    _runId = await json.decode(createRun.body)['id'];
    return createRun;
  }

  Future verifyRun() async {
    String status = '';
    while (status != 'completed') {
      var request = await get(url: '/threads/$_thread/runs/$_runId');
      status = await json.decode(request.body)['status'];
    }
  }

  Future<String?> listMessage() async {
    final request = await get(url: '/threads/$_thread/messages');
    final decodedJson = utf8.decode(request.body.runes.toList());
    final message = jsonDecode(decodedJson)['data'][0]['content'][0]['text']['value'];
    return message;
  }

  Future listAllMessages() async {
    final request = await get(url: '/threads/$_thread/messages');
    final decodedJson = utf8.decode(request.body.runes.toList());
    final messages = jsonDecode(decodedJson)['data'];
    return messages;
  }

}
