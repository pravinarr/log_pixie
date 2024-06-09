import 'package:devtools_app_shared/ui.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:log_pixie_devtool/src/logs_viewer/view/log_viewer.dart';

/// A Flutter widget that represents the LogPixie DevTool extension.
///
/// This widget is a [DevToolsExtension] that contains a [LogsViewer] widget,
/// which is used to display the logs.
///
/// The [LogsViewer] widget is wrapped in a [RoundedOutlinedBorder] to give it
/// a rounded, outlined appearance.
class LogPixieDevToolExtension extends StatelessWidget {
  /// Creates a [LogPixieDevToolExtension] widget.
  const LogPixieDevToolExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(
      child: RoundedOutlinedBorder(
          child: LogsViewer()), // Build your extension here
    );
  }
}
