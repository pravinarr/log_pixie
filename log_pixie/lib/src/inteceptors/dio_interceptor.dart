import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:log_pixie/src/logger/loggers.dart';
import 'package:log_pixie/src/model/logger_base.dart';

class PixieDioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      LogPixie.logNetwork(_requestToJson(options));
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      LogPixie.logNetwork(_responseToJson(response));
    }
    super.onResponse(response, handler);
  }

  Map<String, dynamic> _responseToJson(Response response) {
    return HttpResponseData.fromDioResponse(
      response,
    ).toJson();
  }

  //method to convert request to json
  Map<String, dynamic> _requestToJson(RequestOptions request) {
    return HttpRequestData.fromDioRequest(
      request,
    ).toJson();
  }
}
