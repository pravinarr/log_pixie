part of 'widgets.dart';

/// A Flutter widget that displays the information of a log.
///
/// This widget takes a [LogData] object as a parameter and displays
/// the type and message of the log in an [ExpansionTile]. The data of the log
/// is displayed in a [JsonView] widget.
///
/// The [ExpansionTile] is initially collapsed and can be expanded to view
/// the data of the log.
///
/// The type of the log is displayed in a [Chip] widget with a yellow background.
///
/// If the log does not have a message, an empty string is displayed instead.
class InfoViewer extends StatelessWidget {
  /// Creates an [InfoViewer] widget.
  ///
  /// The [log] parameter must not be null.
  const InfoViewer({
    required this.log,
    super.key,
  });

  /// The log data to display.
  final LogData log;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Row(
          children: [
            Chip(
              label: Text(
                log.type.name,
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.yellow.shade200,
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