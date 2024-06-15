import 'package:chatbot/interfaces/DbInterface.dart';

class DataBase {
  static DbInterface? conn;

  static Future init (DbInterface dbInterface) async {
    conn = dbInterface;
    await conn?.connect();
  }
}