import 'package:chatbot/interfaces/ApiInterface.dart';

class Openai {
  final ApiInterface? _request;
  final String _baseUri = 'https://api.openai.com/v1';

  Openai({required ApiInterface apiInterface, required headers, baseUri}) : _request = apiInterface {
    _request?.setBaseUri(baseUri: baseUri ?? _baseUri);
    _request?.setHeaders(headers: headers);
  }

  getRequest() {
    return _request;
  }

}