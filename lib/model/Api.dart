import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final Map<String, String> headers;

  const Api({required this.headers});

  Future<http.Response> post({required String url, Map<String, dynamic>? body}) async {
    return await http.post(
        Uri.parse(url),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> get({required String url}) async {
    return await http.get(
      Uri.parse(url),
      headers: headers
    );
  }
}