import 'package:chatbot/model/Assistant.dart';
import 'package:chatbot/model/HttpRequest.dart';

class ChatController {
  Assistant? assistant;

  ChatController() {
    assistant = Assistant(
        apiInterface: HttpRequest(),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${const String.fromEnvironment('OPENAI_TOKEN')}',
          'OpenAI-Beta': 'assistants=v2'
        }
    );
  }

  Future<String?> sendMessage({required String message}) async {
    await assistant?.createThread();
    await assistant?.createMessage(message: message);
    await assistant?.createRun();
    return await assistant?.assistantResponse();
  }
}