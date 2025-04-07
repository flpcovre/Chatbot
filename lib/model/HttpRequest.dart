import 'package:chatbot/interfaces/IApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpRequest implements IApi {
  Map<String, String>? headers;
  String? baseUri;

  HttpRequest({this.headers, this.baseUri});

  @override
  Future<http.Response> post(
      {required String url, Map<String, dynamic>? body}) async {
    return await http.post(
      Uri.parse(baseUri! + url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  @override
  Future<http.Response> get({required String url}) async {
    return await http.get(Uri.parse(baseUri! + url), headers: headers);
  }

  @override
  void setHeaders({required headers}) {
    this.headers = headers;
  }

  @override
  void setBaseUri({required String baseUri}) {
    this.baseUri = baseUri;
  }
}
