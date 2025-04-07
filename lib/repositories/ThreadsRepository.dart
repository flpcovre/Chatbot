import 'package:chatbot/model/dao/ResultSet.dart';

class ThreadsRepository {
  Future<dynamic> getActiveThreadByUser(int userId) async {
    var rs = await ResultSet.select(
        "SELECT thread_key FROM threads WHERE user_id = $userId AND active = 1");
    return rs;
  }

  Future<void> disableThread(int userId) async {
    ResultSet.execute(
        "UPDATE threads SET active = 0 WHERE user_id = $userId AND id IN (SELECT max(id) FROM threads WHERE user_id = $userId AND active = 1)");
  }
}
