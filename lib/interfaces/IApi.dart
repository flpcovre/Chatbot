import 'package:http/http.dart' as http;

abstract class IApi {
  Future<http.Response> post({required String url, Map<String, dynamic>? body});
  Future<http.Response> get({required String url});
  void setHeaders({required headers});
  void setBaseUri({required String baseUri});
}
