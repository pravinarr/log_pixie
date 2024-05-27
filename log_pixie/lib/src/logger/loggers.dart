import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

const String logPixie = 'log_pixie';

enum LogType { message, error, warning, https }

class LogPixie {
  static void logInfo(String message, [Map<String, String>? data]) {
    if (kDebugMode) {
      developer.postEvent(logPixie, <String, String>{
        'type': LogType.message.name,
        'message': message,
        'data': jsonEncode(data),
      });
    }
  }

  static void logError(String error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      developer.postEvent(logPixie, <String, String>{
        'type': LogType.error.name,
        'error': error,
        'stackTrace': stackTrace.toString(),
      });
    }
  }

  static void logWarning(String warning, [Map<String, String>? data]) {
    if (kDebugMode) {
      developer.postEvent(logPixie, <String, String>{
        'type': LogType.warning.name,
        'message': warning,
        'data': jsonEncode(data),
      });
    }
  }

  static void logHttps(Map<String, dynamic>? data) {
    if (kDebugMode) {
      developer.postEvent(logPixie, <String, String>{
        'type': LogType.https.name,
        'data': jsonEncode(data),
      });
    }
  }
}
