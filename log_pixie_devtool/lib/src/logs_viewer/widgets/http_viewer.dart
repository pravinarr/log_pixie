part of 'widgets.dart';

class HttpViewer extends StatelessWidget {
  /// Creates an [HttpViewer] widget.
  ///
  /// The [log] parameter must not be null.
  const HttpViewer({
    required this.log,
    super.key,
  });

  /// The log data to display.
  final LogData log;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Split(
            axis: Axis.horizontal,
            initialFractions: const [0.5, 0.5],
            children: [
              JsonView(
                json: log.networkRequest.toJson(),
                animation: true,
              ),
              if (log.isHttpResponse)
                JsonView(
                  json: log.networkResponse.toSelectiveJson(),
                  animation: true,
                )
              else
                const Center(child: Text('No response data')),
            ],
          ),
        ),
      ],
    );
  }
}
