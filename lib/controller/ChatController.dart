import 'package:chatbot/factories/BubbleFactory.dart';
import 'package:chatbot/model/Openai/Assistant.dart';
import 'package:chatbot/model/HttpRequest.dart';
import 'package:chatbot/model/SharedPrefs.dart';
import 'package:chatbot/model/Usuario.dart';
import 'package:chatbot/model/dao/ResultSet.dart';

class ChatController {
  Assistant? assistant;
  final Usuario _usuario = Usuario();
  final userId = SharedPrefs.instance.getInt('userId');

  ChatController() {
    assistant = Assistant(
        apiInterface: HttpRequest(),
        assistantId: const String.fromEnvironment("ASSISTANT1"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${const String.fromEnvironment('OPENAI_TOKEN')}',
          'OpenAI-Beta': 'assistants=v2'
        }
    );
  }

  Future<String?> sendMessage({required String message}) async {
    var rs = await ResultSet.select("SELECT cod_thread FROM threads WHERE cod_usuario = $userId AND ativo = 1");
    if (!rs.isEmpty) {
      await assistant?.createThread(
          threadId: rs[0]['cod_thread']
      );
    } else {
      var threadId = await assistant?.createThread();
      await ResultSet.execute("INSERT INTO threads VALUES (id, '$threadId', ${userId.toString()}, 1)");
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
    ResultSet.execute("UPDATE threads SET ativo = 0 WHERE cod_usuario = $userId AND id IN (SELECT max(id) FROM threads WHERE cod_usuario = $userId AND ativo = 1)");
  }

  Future listAllMessages() async {
    final List<BubbleFactory> messages = [];
    RegExp exp = RegExp(r'【[^【】]*】');

    var rs = await ResultSet.select("SELECT cod_thread FROM threads WHERE cod_usuario = $userId AND ativo = 1");

    if (!rs.isEmpty) {
      await assistant?.createThread(
          threadId: rs[0]['cod_thread']
      );
      var data = await assistant?.listAllMessages();
      messages.add(
          const BubbleFactory(message: 'Olá, como posso te ajudar?', type: 'A')
      );
      data.forEach((value) {
        String message = value['content'][0]['text']['value'].replaceAll(exp, '');

        messages.insert(1,
            BubbleFactory(message: message, type: (value['role'] == 'assistant' ? 'A' : 'U'))
        );
      });
    } else {
      messages.add(
          const BubbleFactory(message: 'Olá, como posso te ajudar?', type: 'A')
      );
    }

    return messages;
  }
}