import 'package:chatbot/model/dao/ResultSet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ResultSet {
  @override
  String? primaryKey = "id";
  @override
  String? table = "users";

  List<String> fillable = ['name', 'email', 'password'];

  Future<Object> make(Map<String, String> data) async {
    final filteredData = {
      for (var key in data.keys)
        if (fillable.contains(key)) key: data[key]!
    };

    final hasAllFields =
        fillable.every((field) => filteredData.containsKey(field));

    if (!hasAllFields) {
      return {'status': 'error', 'message': 'Missing required fields'};
    }

    try {
      await create(filteredData);
      return data;
    } catch (e) {
      return {'status': 'error', 'message': 'Error: $e'};
    }
  }

  Future<bool> validate(email, password) async {
    var userResult =
        await find('WHERE email = "$email" AND password = "$password"');
    return !userResult.isEmpty ? true : false;
  }
}
