import 'dart:convert';

import 'package:log_pixie/src/logger/loggers.dart';

class LogData {
  final LogType type;
  final Map<String, dynamic>? data;
  final String? message;

  LogData({required this.type, this.data, this.message});

  static LogData fromJson(Map<String, dynamic> json) {
    return LogData(
        type: LogType.values
            .firstWhere((element) => element.name == json['type']),
        data: json['data'] == 'null' ? null : jsonDecode(json['data']),
        message: json['message']);
  }
}
