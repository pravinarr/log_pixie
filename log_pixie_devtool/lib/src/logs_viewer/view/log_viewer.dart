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

  bool _showNetworkLogs = true;
  bool _showInfoLogs = true;
  bool _showWarningLogs = true;
  bool _showErrorLogs = true;

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
            message: 'Network logs',
            child: Row(
              children: [
                const Text(
                  'Network',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Checkbox(
                  value: _showNetworkLogs,
                  onChanged: (value) {
                    setState(() {
                      _showNetworkLogs = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Tooltip(
            message: 'Info logs',
            child: Row(
              children: [
                const Text(
                  'Info',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Checkbox(
                  value: _showInfoLogs,
                  onChanged: (value) {
                    setState(() {
                      _showInfoLogs = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Tooltip(
            message: 'Warning logs',
            child: Row(
              children: [
                const Text(
                  'Warning',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Checkbox(
                  value: _showWarningLogs,
                  onChanged: (value) {
                    setState(() {
                      _showWarningLogs = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Tooltip(
            message: 'Error',
            child: Row(
              children: [
                const Text(
                  'Error',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Checkbox(
                  value: _showErrorLogs,
                  onChanged: (value) {
                    setState(() {
                      _showErrorLogs = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) => switch (logs[index].type) {
            LogType.info => _showInfoLogs
                ? InfoViewer(log: logs[index])
                : const SizedBox.shrink(),
            LogType.warning => _showWarningLogs
                ? WarningViewer(log: logs[index])
                : const SizedBox.shrink(),
            LogType.error => _showErrorLogs
                ? ErrorViewer(log: logs[index])
                : const SizedBox.shrink(),
            LogType.network => _showNetworkLogs
                ? HttpViewer(
                    log: logs[index],
                  )
                : const SizedBox.shrink(),
          },
          itemCount: logs.length,
        ),
      ),
    );
  }
}
