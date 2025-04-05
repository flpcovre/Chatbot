import 'package:chatbot/model/User.dart';

class UserRepository {
  final User _user = User();

  Future<Object> createUser(Map<String, String> data) async {
    return await _user.make(data);
  }

  Future<bool> validateUser(String email, String password) async {
    return await _user.validate(email, password);
  }

  Future<dynamic> findByEmail(String email) async {
    return await _user.find('WHERE email = "$email"');
  }
}