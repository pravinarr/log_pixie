part of 'widgets.dart';

class LogsTable extends StatefulWidget {
  const LogsTable({super.key});

  @override
  State<LogsTable> createState() => _LogsTableState();
}

class _LogsTableState extends State<LogsTable> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logs =
        context.select((LogsViewerCubit cubit) => cubit.state.filteredLogs);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocListener<LogsViewerCubit, LogsViewerState>(
      listener: (context, state) {
        if (state.shouldAutoScroll && logs.length > 20) {
          _scrollController.autoScrollToBottom();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(child: SizedBox.shrink()),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SearchLogField(),
                  )),
            ],
          ),
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: logs.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              final headerStyle = TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              );
              return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              'When',
                              style: headerStyle,
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              'Type',
                              style: headerStyle,
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              'Data',
                              style: headerStyle,
                            ),
                          )),
                    ],
                  ));
            }
            final log = logs[index - 1];
            return InkWell(
              onTap: () {
                context.read<LogsViewerCubit>().selectLog(log);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          log.when,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8),
                        alignment: Alignment.center,
                        child: Chip(
                          label: Text(
                            log.buildTypeString,
                            style: TextStyle(color: log.colorChipText),
                          ),
                          backgroundColor: log.colorChip,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            if (log.type != LogType.network) ...[
                              TextSpan(
                                text: log.message,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const WidgetSpan(
                                  child: SizedBox(
                                width: 8,
                              )),
                            ] else ...[
                              TextSpan(
                                text: log.isHttpResponse
                                    ? log.networkResponse.request.method
                                    : log.networkRequest.method,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const WidgetSpan(
                                  child: SizedBox(
                                width: 4,
                              )),
                              TextSpan(
                                text: log.isHttpResponse
                                    ? log.networkResponse.statusCode.toString()
                                    : '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const WidgetSpan(
                                  child: SizedBox(
                                width: 8,
                              )),
                            ],
                            TextSpan(
                              text: jsonEncode(
                                log.data,
                              ),
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
