import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:log_pixie/src/logger/loggers.dart';

class HttpInterceptor extends http.BaseClient {
  final http.Client _inner;

  HttpInterceptor(this._inner);

  @override
  Future<http.StreamedResponse> send(request) {
    if (kDebugMode) {
      LogPixie.logNetwork(_requestToJson(request as http.Request));
    }
    final response = _inner.send(request);
    if (kDebugMode) {
      LogPixie.logNetwork(_responseToJson(request as http.Response));
    }
    return response;
  }

  /// Method to convert request to json
  Map<String, dynamic> _requestToJson(http.Request request) {
    return {
      'method': request.method,
      'url': request.url,
      'headers': request.headers,
      'body': request.body,
    };
  }

  /// Method to convert response to json
  Map<String, dynamic> _responseToJson(http.Response response) {
    return {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
      'request': _requestToJson(response.request as http.Request)
    };
  }
}
