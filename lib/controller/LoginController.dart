import 'package:chatbot/model/SharedPrefs.dart';
import 'package:chatbot/repositories/UserRepository.dart';

class LoginController {
  final UserRepository _userRepository = UserRepository();

  Future signIn(String email, String password) async {
      var userResult = await _userRepository.validateUser(email, password);

      if (userResult) {
        var user = await _userRepository.findByEmail(email);
        
        SharedPrefs.instance.setString('userId', user[0]['id'].toString());
        SharedPrefs.instance.setString('name', user[0]['name']);
        SharedPrefs.instance.setString('email', user[0]['email']);
        return userResult;
      }

      return false;
  }

  Future signUp(String name, String email, String password1, String password2) async {
      if ((password1 == password2) && (name.trim() != '') && (email.trim() != '') && (password1.trim() != '') && (password2.trim() != '')) {
        Map<String, String> data = {
          'name': name,
          'email': email,
          'password': password1
        };

        if (await _userRepository.validateUser(email, password1)) {
          return false;
        }

        var userResult = await _userRepository.createUser(data) as Map<String, dynamic>;
        
        if (!userResult['status'].contains('error')) {
          return true;
        }

        return false;
      }
      return false;
  }
}