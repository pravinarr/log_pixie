part of 'widgets.dart';

/// A Flutter widget that displays the HTTP logs.
///
/// This widget takes a [LogData] object as a parameter and displays
/// the type and message of the log in an [ExpansionTile]. The data of the log
/// is displayed in a [JsonView] widget.
///
/// The [ExpansionTile] is initially collapsed and can be expanded to view
/// the data of the log.
///
/// The type of the log is displayed in a [Chip] widget with a grey background.
///
/// If the log does not have a message, an empty string is displayed instead.

class HttpViewer extends StatelessWidget {
  /// Creates an [HttpViewer] widget.
  ///
  /// The [log] parameter must not be null.
  const HttpViewer({
    required this.log,
    required this.showOnlyErrors,
    super.key,
  });

  /// The log data to display.
  final LogData log;

  final bool showOnlyErrors;
  @override
  Widget build(BuildContext context) {
    if (showOnlyErrors &&
        (!log.isHttpResponse || log.networkResponse.statusCode < 500)) {
      return const SizedBox();
    }
    return ExpansionTile(
        leading: Chip(
          label: Text(
            log.type.name,
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey.shade200,
        ),
        title: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            _DisplayMethod(log: log),
            const SizedBox(
              width: 8,
            ),
            Chip(
              label: Text(
                log.isHttpResponse ? 'Response' : 'Request',
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.purple.shade50,
            ),
            if (log.isHttpResponse) _ShowStatusCode(log: log),
          ],
        ),
        subtitle: _DisplayPath(log: log),
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                JsonView(json: log.data),
                Positioned(
                  right: 0,
                  top: 0,
                  child: ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: log.isHttpResponse
                              ? log.networkResponse.request.toCurl()
                              : log.networkRequest.toCurl()));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Curl copied to clipboard'),
                        ),
                      );
                    },
                    child: const Text('Copy Curl'),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}

/// A Flutter widget that displays the status code of a log.
///
/// This widget takes a [LogData] object as a parameter and displays
/// the status code of the log in a [Chip] widget.
///
/// The background color of the [Chip] is red if the status code is greater than 499,
/// otherwise it is purple.
class _ShowStatusCode extends StatelessWidget {
  /// Creates a [_ShowStatusCode] widget.
  ///
  /// The [log] parameter must not be null.
  const _ShowStatusCode({
    required this.log,
  });

  /// The log data to display.
  final LogData log;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        log.networkResponse.statusCode.toString(),
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: log.networkResponse.statusCode > 499
          ? Colors.red.shade100
          : Colors.purple.shade50,
    );
  }
}

/// A Flutter widget that displays the path of a log.
///
/// This widget takes a [LogData] object as a parameter and displays
/// the path of the log in a [Text] widget.
class _DisplayPath extends StatelessWidget {
  /// Creates a [_DisplayPath] widget.
  ///
  /// The [log] parameter must not be null.
  const _DisplayPath({
    required this.log,
  });

  /// The log data to display.
  final LogData log;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        log.isHttpResponse
            ? log.networkResponse.request.path
            : log.networkRequest.path,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

/// A Flutter widget that displays the method of a log.
///
/// This widget takes a [LogData] object as a parameter and displays
/// the method of the log in a [Chip] widget.
class _DisplayMethod extends StatelessWidget {
  /// Creates a [_DisplayMethod] widget.
  ///
  /// The [log] parameter must not be null.
  const _DisplayMethod({
    required this.log,
  });

  /// The log data to display.
  final LogData log;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        log.isHttpResponse
            ? log.networkResponse.request.method
            : log.networkRequest.method,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
