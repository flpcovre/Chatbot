import 'package:http/http.dart' as http;
import 'package:chatbot/model/ChatAPI.dart';
import 'package:chatbot/model/Api.dart';

class ChatController {
  ChatAPI? chatAPI;

  ChatController() {
    chatAPI = ChatAPI(
        apiInterface: Api(),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${const String.fromEnvironment('OPENAI_TOKEN')}',
          'OpenAI-Beta': 'assistants=v2'
        }
    );
  }

  Future<String?> sendMessage({required String message}) async {
    await chatAPI?.createThread();
    await chatAPI?.createMessage(message: message);
    await chatAPI?.createRun();
    return await chatAPI?.assistantResponse();
  }
}