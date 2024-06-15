import 'package:chatbot/model/dao/ResultSet.dart';

class Usuario extends ResultSet {
  @override
  String? primaryKey = "CD_USUARIO";
  @override
  String? table = "usuarios";
}