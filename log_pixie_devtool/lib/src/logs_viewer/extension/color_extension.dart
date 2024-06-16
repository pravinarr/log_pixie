import 'package:flutter/material.dart';
import 'package:log_pixie/log_pixie.dart';

extension ColorExtension on LogData {
  Color get colorChip {
    switch (type) {
      case LogType.info:
        return Colors.blue.shade100;
      case LogType.error:
        return Colors.red.shade100;
      case LogType.warning:
        return Colors.orange.shade100;
      case LogType.network:
        return Colors.green.shade100;
    }
  }

  Color get colorChipText {
    switch (type) {
      case LogType.info:
        return Colors.black;
      case LogType.error:
        return Colors.black;
      case LogType.warning:
        return Colors.black;
      case LogType.network:
        return Colors.black;
    }
  }
}
