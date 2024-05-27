import 'package:devtools_app_shared/ui.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:log_pixie/log_pixie.dart';

class LogsViewer extends StatefulWidget {
  const LogsViewer({super.key});

  @override
  State<LogsViewer> createState() => _LogsViewerState();
}

class _LogsViewerState extends State<LogsViewer> {
  List<LogData> logs = [];

  @override
  void initState() {
    serviceManager.service?.onExtensionEvent.where((event) {
      return event.extensionKind == 'log_me';
    }).listen((event) {
      setState(() {
        logs.add(LogData.fromJson(event.extensionData?.data ?? {}));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Split(
      initialFractions: const [
        0.9,
        0.1,
      ],
      axis: Axis.horizontal,
      children: [
        ListView(
          children: logs.map((log) {
            return ListTile(
              title: Text(log.message ?? ''),
              subtitle: Text(log.type.name),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 100,
          child: Placeholder(),
        ),
      ],
    );
  }
}
