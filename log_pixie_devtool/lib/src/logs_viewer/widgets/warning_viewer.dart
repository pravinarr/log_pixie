part of 'widgets.dart';

/// A Flutter widget that displays the warning of a log.
///
/// This widget takes a [LogData] object as a parameter and displays
/// the type and message of the log in an [ExpansionTile]. The data of the log
/// is displayed in a [JsonView] widget.
///
/// The [ExpansionTile] is initially collapsed and can be expanded to view
/// the data of the log.
///
/// The type of the log is displayed in a [Chip] widget with an orange background.
///
/// If the log does not have a message, an empty string is displayed instead.
class WarningViewer extends StatelessWidget {
  /// Creates a [WarningViewer] widget.
  ///
  /// The [log] parameter must not be null.
  const WarningViewer({
    required this.log,
    super.key,
  });

  /// The log data to display.
  final LogData log;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Row(
          children: [
            Chip(
              label: Text(
                log.type.name,
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.orange.shade200,
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(child: Text(log.message ?? ''))
          ],
        ),
        children: [
          SizedBox(
            height: 200,
            child: JsonView(json: log.data),
          ),
        ]);
  }
}
