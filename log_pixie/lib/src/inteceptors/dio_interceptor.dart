import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:log_pixie/src/logger/loggers.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      LogPixie.logHttps(_requestToJson(options));
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      LogPixie.logHttps(_responseToJson(response));
    }
    super.onResponse(response, handler);
  }

  Map<String, dynamic> _responseToJson(Response response) {
    return {
      'statusCode': response.statusCode,
      'data': response.data,
      'headers': response.headers.map,
      'request': _requestToJson(response.requestOptions),
    };
  }

  //method to convert request to json
  Map<String, dynamic> _requestToJson(RequestOptions request) {
    return {
      'method': request.method,
      'path': request.path,
      'queryParameters': request.queryParameters,
      'data': request.data,
      'headers': request.headers,
    };
  }
}
