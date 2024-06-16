part of 'logs_viewer_cubit.dart';

class LogsViewerState extends Equatable {
  final List<LogData> logs;
  final bool shouldAutoScroll;
  final bool showNetworkLogs;
  final bool showInfoLogs;
  final bool showWarningLogs;
  final bool showErrorLogs;
  final LogData? selectedLog;
  final String? searchQuery;

  const LogsViewerState({
    this.logs = const <LogData>[],
    this.shouldAutoScroll = true,
    this.showNetworkLogs = true,
    this.showInfoLogs = true,
    this.showWarningLogs = true,
    this.showErrorLogs = true,
    this.selectedLog,
    this.searchQuery,
  });

  @override
  List<Object> get props => [
        logs,
        shouldAutoScroll,
        showNetworkLogs,
        showInfoLogs,
        showWarningLogs,
        showErrorLogs,
        if (selectedLog != null) selectedLog!,
        if (searchQuery != null) searchQuery!,
      ];

  LogsViewerState copyWith({
    List<LogData>? logs,
    bool? shouldAutoScroll,
    bool? showNetworkLogs,
    bool? showInfoLogs,
    bool? showWarningLogs,
    bool? showErrorLogs,
    LogData? selectedLog,
    String? searchQuery,
  }) {
    return LogsViewerState(
      logs: logs ?? this.logs,
      shouldAutoScroll: shouldAutoScroll ?? this.shouldAutoScroll,
      showNetworkLogs: showNetworkLogs ?? this.showNetworkLogs,
      showInfoLogs: showInfoLogs ?? this.showInfoLogs,
      showWarningLogs: showWarningLogs ?? this.showWarningLogs,
      showErrorLogs: showErrorLogs ?? this.showErrorLogs,
      selectedLog: selectedLog ?? selectedLog,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  LogsViewerState addNewLog(
    LogData log,
  ) {
    final newLogs = logs.toList()..add(log);
    return copyWith(
      logs: newLogs,
      selectedLog: selectedLog,
    );
  }

  List<LogData> get filteredLogs {
    return logs.where((element) {
      if (searchQuery != null && element.data != null) {
        return (element.message != null &&
                element.message!.contains(searchQuery!)) ||
            element.data!.keys.join().contains(searchQuery!) ||
            element.data!.values.join().contains(searchQuery!);
      }
      return true;
    }).where((log) {
      if (log.type == LogType.network) {
        return showNetworkLogs;
      }
      if (log.type == LogType.info) {
        return showInfoLogs;
      }
      if (log.type == LogType.warning) {
        return showWarningLogs;
      }
      if (log.type == LogType.error) {
        return showErrorLogs;
      }
      return false;
    }).toList();
  }
}
