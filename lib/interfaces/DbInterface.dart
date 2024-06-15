
abstract class DbInterface {
  Future connect();
  void disconnect();
  Future query(String sql);
  List fetchAll();
}