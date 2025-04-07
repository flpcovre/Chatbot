import 'package:chatbot/factories/BubbleFactory.dart';
import 'package:chatbot/model/Openai/Assistant.dart';
import 'package:chatbot/model/HttpRequest.dart';
import 'package:chatbot/model/SharedPrefs.dart';
import 'package:chatbot/model/dao/ResultSet.dart';
import 'package:chatbot/repositories/ThreadsRepository.dart';
import 'package:chatbot/repositories/UserRepository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatController {
  final UserRepository _userRepository = UserRepository();
  final ThreadsRepository _threadsRepository = ThreadsRepository();
  final userId = SharedPrefs.instance.getString('userId') ?? '0';

  Assistant? assistant;
  Map<String, String>? user;

  ChatController() {
    assistant = Assistant(
        apiInterface: HttpRequest(),
        assistantId: dotenv.env['ASSISTANT1'] ?? '',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['OPENAI_TOKEN']}',
          'OpenAI-Beta': 'assistants=v2'
        });
  }

  Future<String?> sendMessage({required String message}) async {
    var rs = await _threadsRepository.getActiveThreadByUser(int.parse(userId));

    if (!rs.isEmpty) {
      await assistant?.createThread(threadId: rs[0]['thread_key']);
    } else {
      var threadId = await assistant?.createThread();
      await ResultSet.execute(
          "INSERT INTO threads VALUES (id, '$threadId', ${userId.toString()}, 1)");
    }

    await assistant?.createMessage(message: message);
    await assistant?.createRun();
    await assistant?.verifyRun();
    String? messageResponse = await assistant?.listMessage();
    RegExp exp = RegExp(r'【[^【】]*】');
    final clearMessage = messageResponse?.replaceAll(exp, '');
    return clearMessage;
  }

  Future clearChat() async {
    _threadsRepository.disableThread(int.parse(userId));
  }

  Future listAllMessages() async {
    final List<BubbleFactory> messages = [];
    RegExp exp = RegExp(r'【[^【】]*】');

    var rs = await _threadsRepository.getActiveThreadByUser(int.parse(userId));

    if (!rs.isEmpty) {
      await assistant?.createThread(threadId: rs[0]['thread_key']);
      var data = await assistant?.listAllMessages();
      messages.add(const BubbleFactory(
          message: 'Olá, como posso te ajudar?', type: 'A'));
      data.forEach((value) {
        String message =
            value['content'][0]['text']['value'].replaceAll(exp, '');

        messages.insert(
            1,
            BubbleFactory(
                message: message,
                type: (value['role'] == 'assistant' ? 'A' : 'U')));
      });
    } else {
      messages.add(const BubbleFactory(
          message: 'Olá, como posso te ajudar?', type: 'A'));
    }

    return messages;
  }
}
