import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:log_pixie/log_pixie.dart';

part 'logs_viewer_state.dart';

class LogsViewerCubit extends Cubit<LogsViewerState> {
  LogsViewerCubit() : super(const LogsViewerState()) {
    _streamSubscriptionLogs =
        serviceManager.service?.onExtensionEvent.where((event) {
      return event.extensionKind == logPixie;
    }).listen((event) {
      updateLogs(LogData.fromJson(event.extensionData?.data ?? {}));
    });

    // listen to connected app hot restart
    serviceManager.isolateManager.selectedIsolate.addListener(reset);
  }

  StreamSubscription? _streamSubscriptionLogs;

  @override
  Future<void> close() {
    _streamSubscriptionLogs?.cancel();
    serviceManager.isolateManager.selectedIsolate.removeListener(reset);
    return super.close();
  }

  void updateLogs(LogData log) {
    emit(state.addNewLog(log));
  }

  void toggleAutoScroll() {
    emit(state.copyWith(shouldAutoScroll: !state.shouldAutoScroll));
  }

  void toggleNetworkLogs() {
    emit(state.copyWith(showNetworkLogs: !state.showNetworkLogs));
  }

  void toggleInfoLogs() {
    emit(state.copyWith(showInfoLogs: !state.showInfoLogs));
  }

  void toggleWarningLogs() {
    emit(state.copyWith(showWarningLogs: !state.showWarningLogs));
  }

  void toggleErrorLogs() {
    emit(state.copyWith(showErrorLogs: !state.showErrorLogs));
  }

  void clearLogs() {
    emit(state.copyWith(logs: []));
  }

  void selectLog(LogData log) {
    emit(state.copyWith(selectedLog: log));
  }

  void reset() {
    emit(const LogsViewerState());
  }

  void search(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void hotRestart() async{
    await serviceManager.connectedApp?.serviceManager?.performHotRestart();
  }
}
