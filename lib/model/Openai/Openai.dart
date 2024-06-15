import 'package:chatbot/interfaces/ApiInterface.dart';
import 'package:http/http.dart' as http;

class Openai {

  /// Attribute responsible for performing actions with the api
  /// @final ApiInterface
  final ApiInterface _request;

  /// Base url for integration with Openai api
  /// @final String
  final String _baseUri = 'https://api.openai.com/v1';

  Openai({required ApiInterface apiInterface, required headers, baseUri}) : _request = apiInterface {
    setBaseUri(baseUri: baseUri ?? _baseUri);
    setHeaders(headers: headers);
  }

  Future<http.Response> post({required String url, Map<String, dynamic>? body}) async {
    return await _request.post(url: url, body: body);
  }

  Future<http.Response> get({required String url}) async {
    return await _request.get(url: url);
  }

  void setHeaders({required headers}) {
    _request.setHeaders(headers: headers);
  }

  void setBaseUri({required String baseUri}) {
    _request.setBaseUri(baseUri: baseUri);
  }

}
