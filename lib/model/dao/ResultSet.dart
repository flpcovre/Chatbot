import 'package:chatbot/model/dao/DataBase.dart';

abstract class ResultSet extends DataBase {
  String? primaryKey;
  String? table;

  Future<dynamic> findById(List id) async {
    String ids = id.join(", ");
    await DataBase.conn?.query("SELECT * FROM $table WHERE $primaryKey IN ($ids)");
    var results = DataBase.conn?.fetchAll();
    return results;
  }

  Future<dynamic> find(String where) async {
    await DataBase.conn?.query("SELECT * FROM $table $where");
    var results = DataBase.conn?.fetchAll();
    return results;
  }

  Future create(Map<String, String> data) async {
    final columns = data.keys.join(', ');
    final values = data.values.map((value) => "'$value'").join(', ');
    await DataBase.conn?.query("INSERT INTO $table ($columns) VALUES ($values)");
  }

  Future update(Map<String, String> data, List id) async {
    List<String> keyValuePairs = [];
    data.forEach((key, value) {
      String pair = "$key = '$value'";
      keyValuePairs.add(pair);
    });
    String result = keyValuePairs.join(', ');
    String ids = id.join(", ");

    await DataBase.conn?.query("UPDATE $table SET $result WHERE $primaryKey IN ($ids)");
  }

  Future delete(List id) async {
    String ids = id.join(", ");
    await DataBase.conn?.query("DELETE FROM $table WHERE $primaryKey IN ($ids)");
  }

  static Future select(sql) async {
    await DataBase.conn?.query(sql);
    var results = DataBase.conn?.fetchAll();
    return results;
  }

  static Future execute(sql) async {
    await DataBase.conn?.query(sql);
  }
}