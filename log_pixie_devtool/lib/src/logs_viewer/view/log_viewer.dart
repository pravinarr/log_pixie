import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log_pixie_devtool/src/logs_viewer/cubit/logs_viewer_cubit.dart';
import 'package:log_pixie_devtool/src/logs_viewer/widgets/widgets.dart';

class LogsViewer extends StatelessWidget {
  /// Creates a [LogsViewer] widget.
  const LogsViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return LogsViewerProvider(
      child: BlocBuilder<LogsViewerCubit, LogsViewerState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey.shade900,
                leading: const Image(image: AssetImage('assets/log_pixie.png')),
                title: const Text('LogPixie'),
                centerTitle: false,
                actions: [
                  _ActionButtons(state: state),
                ],
              ),
              body: Split(
                axis: Axis.vertical,
                initialFractions: const [0.8, 0.2],
                children: const [
                  LogsTable(),
                  SelectedLogViewer(),
                ],
              ));
        },
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.state});

  final LogsViewerState state;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message: 'Show Network logs',
          child: Row(
            children: [
              const Text(
                'Network',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Checkbox(
                value: state.showNetworkLogs,
                onChanged: (value) {
                  context.read<LogsViewerCubit>().toggleNetworkLogs.call();
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Tooltip(
          message: 'Show Info logs',
          child: Row(
            children: [
              const Text(
                'Info',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Checkbox(
                value: state.showInfoLogs,
                onChanged: (value) {
                  context.read<LogsViewerCubit>().toggleInfoLogs.call();
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Tooltip(
          message: 'Show Warning logs',
          child: Row(
            children: [
              const Text(
                'Warning',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Checkbox(
                value: state.showWarningLogs,
                onChanged: (value) {
                  context.read<LogsViewerCubit>().toggleWarningLogs.call();
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Tooltip(
          message: 'Show Error logs',
          child: Row(
            children: [
              const Text(
                'Error',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Checkbox(
                value: state.showErrorLogs,
                onChanged: (value) {
                  context.read<LogsViewerCubit>().toggleErrorLogs.call();
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Tooltip(
          message: state.shouldAutoScroll
              ? 'Pause auto-scroll'
              : 'Resume auto-scroll',
          child: IconButton(
            icon: Icon(
              state.shouldAutoScroll ? Icons.pause : Icons.play_arrow,
            ),
            onPressed: () {
              context.read<LogsViewerCubit>().toggleAutoScroll.call();
            },
          ),
        ),
        Tooltip(
          message: 'Clear logs',
          child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              context.read<LogsViewerCubit>().clearLogs.call();
            },
          ),
        ),
      ],
    );
  }
}
