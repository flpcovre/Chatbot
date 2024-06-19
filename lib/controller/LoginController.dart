import 'package:chatbot/model/SharedPrefs.dart';
import 'package:chatbot/model/Usuario.dart';
import 'package:chatbot/model/dao/ResultSet.dart';

class LoginController {
  final Usuario _usuario = Usuario();

  Future signIn(String user, String password) async {
      var userResult = await ResultSet.select("SELECT cod_usuario FROM usuarios WHERE username = '$user' AND password = '$password'");
      if (!userResult.isEmpty) {
        SharedPrefs.instance.setInt('userId', int.parse(userResult[0]['cod_usuario']));
        return true;
      }
      return false;
  }

  Future signUp(String name, String user, String password1, String password2) async {
      if ((password1 == password2) && (name.trim() != '') && (user.trim() != '') && (password1.trim() != '') && (password2.trim() != '')) {
        Map<String, String> data = {
          'nome': name,
          'username': user,
          'password': password1
        };

        try {
          await _usuario.create(data);
          return true;
        } catch (e) {
          return false;
        }
      }
      return false;
  }
}