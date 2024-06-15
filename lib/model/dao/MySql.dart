import 'dart:ffi';
import 'package:mysql_client/mysql_client.dart';
import 'package:chatbot/interfaces/DbInterface.dart';

class MySql implements DbInterface {
  dynamic _conn;
  dynamic _statement;
  List<dynamic> _result = [];
  late final String _dbName;
  late final String _dbHost;
  late final String _dbUser;
  late final String _dbPassword;
  late final int _dbPort;


  MySql({String? database, String? host, String? user, String? password, int? port}) {
    _dbName = database ?? const String.fromEnvironment('DBNAME');
    _dbHost = host ?? const String.fromEnvironment('DBHOST');
    _dbUser = user ?? const String.fromEnvironment('DBUSER');
    _dbPassword = password ?? const String.fromEnvironment('DBPASSWORD');
    _dbPort = port ?? const int.fromEnvironment("DBPORT");
  }

  @override
  Future connect() async {
    _conn = await MySQLConnection.createConnection(
        host: _dbHost,
        port: _dbPort,
        userName: _dbUser,
        password: _dbPassword,
        databaseName: _dbName,
        secure: false
    );
    await _conn.connect();
  }

  @override
  void disconnect() {
    _conn = null;
  }

  @override
  Future query(String sql) async {
    _statement = await _conn.execute(sql);
  }

  @override
  List fetchAll() {
    _result = [];
    for (final rows in _statement.rows) {
      _result.add(rows.assoc());
    }
    return _result;
  }

}