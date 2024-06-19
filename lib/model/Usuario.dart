import 'package:chatbot/model/dao/ResultSet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usuario extends ResultSet {
  @override
  String? primaryKey = "cod_usuario";
  @override
  String? table = "usuarios";
}