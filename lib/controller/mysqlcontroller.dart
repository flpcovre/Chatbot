import 'package:mysql_client/mysql_client.dart';

class MysqlController {

  Future connect() async {
    final conn = await MySQLConnection.createConnection(
        host: "192.168.6.107",
        port: 3306,
        userName: "root",
        password: "123",
        databaseName: "projeto",
        secure: false
    );
    await conn.connect();

    var result = await conn.execute("SELECT * FROM usuarios WHERE CD_USUARIO IN (1,2)");

    for (final rows in result.rows) {
      print(rows.assoc());
    }
  }
}