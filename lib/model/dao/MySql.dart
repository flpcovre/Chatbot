import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:chatbot/interfaces/IDatabase.dart';

class MySql implements IDatabase {
  dynamic _conn;
  dynamic _statement;
  List<dynamic> _result = [];
  late final String _dbName;
  late final String _dbHost;
  late final String _dbUser;
  late final String _dbPassword;
  late final int _dbPort;

  MySql(
      {String? database,
      String? host,
      String? user,
      String? password,
      int? port}) {
    _dbName = database ?? dotenv.env['DBNAME'] ?? '';
    _dbHost = host ?? dotenv.env['DBHOST'] ?? '';
    _dbUser = user ?? dotenv.env['DBUSER'] ?? '';
    _dbPassword = password ?? dotenv.env['DBPASSWORD'] ?? '';
    _dbPort = port ?? int.tryParse(dotenv.env['DBPORT'] ?? '0') ?? 0;
  }

  @override
  Future connect() async {
    _conn = await MySQLConnection.createConnection(
        host: _dbHost,
        port: _dbPort,
        userName: _dbUser,
        password: _dbPassword,
        databaseName: _dbName,
        secure: false);
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
