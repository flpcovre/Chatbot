import 'package:chatbot/model/Usuario.dart';

class LoginController {
  final Usuario _usuario = Usuario();

  Future auth(String user, String password) async {
      bool isAuth = await _usuario.userAuthentication(user, password);
      return isAuth;
  }

  Future signUp(String user, String password1, String password2) async {

  }
}