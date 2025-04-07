import 'package:chatbot/interfaces/IDatabase.dart';

class DataBase {
  static IDatabase? conn;

  static Future init(IDatabase dbInterface) async {
    conn = dbInterface;
    await conn?.connect();
  }
}
