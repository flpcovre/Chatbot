abstract class IDatabase {
  Future connect();
  void disconnect();
  Future query(String sql);
  List fetchAll();
}
