import 'package:chatbot/interfaces/ApiInterface.dart';

class Openai {
  final ApiInterface? _request;
  final String _baseUri = 'https://api.openai.com/v1';

  Openai({required ApiInterface apiInterface, required headers, baseUri}) : _request = apiInterface {
    _request?.setBaseUri(baseUri: baseUri ?? _baseUri);
    _request?.setHeaders(headers: headers);
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
