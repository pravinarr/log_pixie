import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:log_pixie/src/logger/loggers.dart';

class LogData {
  final String when;
  final LogType type;
  final Map<String, dynamic>? data;
  final String? message;

  LogData({required this.type, required this.when, this.data, this.message});

  static LogData fromJson(Map<String, dynamic> json) {
    return LogData(
        when: json['when'],
        type: LogType.values
            .firstWhere((element) => element.name == json['type']),
        data: json['data'] == 'null' ? null : jsonDecode(json['data']),
        message: json['message']);
  }

  bool get isNetworkLog => type == LogType.network;

  String get buildTypeString =>
      '${type.name} ${isNetworkLog ? ' - ${isHttpResponse ? 'Response' : 'Request'}' : ''}';

  bool get isHttpResponse =>
      type == LogType.network ? data!['statusCode'] != null : false;

  HttpRequestData get networkRequest => isHttpResponse
      ? HttpResponseData.fromJson(data!).request
      : HttpRequestData.fromJson(data!);
  HttpResponseData get networkResponse => HttpResponseData.fromJson(data!);

  String get curl => type == LogType.network
      ? isHttpResponse
          ? networkResponse.request.toCurl()
          : networkRequest.toCurl()
      : '';
}

class HttpRequestData {
  final String method;
  final String path;
  final Map<String, dynamic> queryParameters;
  final dynamic data;
  final Map<String, dynamic> headers;

  HttpRequestData(
      {required this.method,
      required this.path,
      required this.queryParameters,
      required this.data,
      required this.headers});

  static HttpRequestData fromJson(Map<String, dynamic> json) {
    return HttpRequestData(
        method: json['method'],
        path: json['path'],
        queryParameters: json['queryParameters'],
        data: json['data'],
        headers: json['headers']);
  }

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'path': path,
      'queryParameters': queryParameters,
      'data': data,
      'headers': headers
    };
  }

  static fromDioRequest(RequestOptions request) {
    return HttpRequestData(
        method: request.method,
        path: request.path,
        queryParameters: request.queryParameters,
        data: request.data,
        headers: request.headers);
  }

  String toCurl() {
    final headerString = headers.entries
        .map((e) => '-H "${e.key}: ${e.value}"')
        .toList()
        .join(' ');
    final queryParamString = queryParameters.entries
        .map((e) => '-d "${e.key}=${e.value}"')
        .toList()
        .join(' ');
    return 'curl -X $method $headerString $queryParamString $path';
  }
}

class HttpResponseData {
  final int statusCode;
  final dynamic data;
  final Map<String, dynamic> headers;
  final HttpRequestData request;

  HttpResponseData(
      {required this.statusCode,
      required this.data,
      required this.headers,
      required this.request});

  static HttpResponseData fromJson(Map<String, dynamic> json) {
    return HttpResponseData(
        statusCode: json['statusCode'],
        data: json['data'],
        headers: json['headers'],
        request: HttpRequestData.fromJson(json['request']));
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'data': data,
      'headers': headers,
      'request': request.toJson()
    };
  }

  Map<String, dynamic> toSelectiveJson() {
    return {
      'statusCode': statusCode,
      'data': data,
      'headers': headers,
    };
  }

  static fromDioResponse(Response response) {
    return HttpResponseData(
        statusCode: response.statusCode!,
        data: response.data,
        headers: response.headers.map,
        request: HttpRequestData.fromDioRequest(response.requestOptions));
  }
}
