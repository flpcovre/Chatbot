import 'package:chatbot/model/dao/ResultSet.dart';

class Usuario extends ResultSet {
  @override
  String? primaryKey = "cod_usuario";
  @override
  String? table = "usuarios";

  Future<dynamic> userAuthentication(String user, String password) async {
    var userResult = await ResultSet.select("SELECT cod_usuario FROM usuarios WHERE username = '$user' AND password = '$password'");

    if (!userResult.isEmpty) {
      ResultSet.execute("UPDATE usuarios SET autenticado = 1, ultimo_acesso = sysdate() WHERE cod_usuario = ${userResult[0]['cod_usuario']}");
      return true;
    }
    
    return false;
  }
}