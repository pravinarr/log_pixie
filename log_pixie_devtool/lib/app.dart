import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:log_pixie_devtool/widgets/log_viewer.dart';

class LogPixieDevToolExtension extends StatelessWidget {
  const LogPixieDevToolExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(
      child: LogsViewer(), // Build your extension here
    );
  }
}
