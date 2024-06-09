import 'dart:async';

import 'package:devtools_app_shared/ui.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:log_pixie/log_pixie.dart';
import 'package:log_pixie_devtool/src/logs_viewer/widgets/widgets.dart';

/// A Flutter widget that displays a list of logs.
///
/// This widget is a [StatefulWidget] that maintains a list of [LogData] objects.
/// Each log is displayed in a [ListView] using a different viewer widget
/// depending on the type of the log.
///
/// The list of logs can be cleared, and auto-scrolling can be paused and resumed
/// using the buttons in the app bar.
///
/// Import this class from the `log_viewer.dart` file.
class LogsViewer extends StatefulWidget {
  /// Creates a [LogsViewer] widget.
  const LogsViewer({super.key});

  @override
  State<LogsViewer> createState() => _LogsViewerState();
}

class _LogsViewerState extends State<LogsViewer> {
  /// The list of logs to display.
  List<LogData> logs = [];

  /// Whether the list should automatically scroll to the bottom when a new log is added.
  bool _shouldAutoScroll = true;

  late ScrollController _scrollController;
  late StreamSubscription? _streamSubscription;

  @override
  void initState() {
    _scrollController = ScrollController();
    _streamSubscription =
        serviceManager.service?.onExtensionEvent.where((event) {
      return event.extensionKind == logPixie;
    }).listen((event) {
      setState(() {
        logs.add(LogData.fromJson(event.extensionData?.data ?? {}));
      });
      if (_shouldAutoScroll) {
        _scrollController.autoScrollToBottom();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        leading: const Image(image: AssetImage('assets/log_pixie.png')),
        title: const Text('Log Pixie'),
        actions: [
          Tooltip(
            message: 'Hot restart the app',
            child: IconButton(
              icon: const Icon(
                Icons.refresh,
              ),
              onPressed: () async {
                serviceManager.serviceExtensionManager.connectedApp
                    .serviceManager?.performHotRestart
                    .call();
              },
            ),
          ),
          Tooltip(
            message:
                _shouldAutoScroll ? 'Pause auto-scroll' : 'Resume auto-scroll',
            child: IconButton(
              icon: Icon(
                _shouldAutoScroll ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: () {
                setState(() {
                  setState(() {
                    _shouldAutoScroll = !_shouldAutoScroll;
                  });
                });
              },
            ),
          ),
          Tooltip(
            message: 'Clear logs',
            child: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  setState(() {
                    logs.clear();
                  });
                });
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) => switch (logs[index].type) {
          LogType.info => InfoViewer(log: logs[index]),
          LogType.warning => WarningViewer(log: logs[index]),
          LogType.error => ErrorViewer(log: logs[index]),
          LogType.network => HttpViewer(log: logs[index]),
        },
        itemCount: logs.length,
      ),
    );
  }
}
