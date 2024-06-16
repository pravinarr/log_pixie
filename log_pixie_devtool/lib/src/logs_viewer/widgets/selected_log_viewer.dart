part of 'widgets.dart';

class SelectedLogViewer extends StatelessWidget {
  const SelectedLogViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final log =
        context.select((LogsViewerCubit cubit) => cubit.state.selectedLog);
    if (log == null) {
      return const SizedBox();
    }

    if (log.type == LogType.network) {
      return RoundedOutlinedBorder(
        child: HttpViewer(
          log: log,
        ),
      );
    }
    return RoundedOutlinedBorder(
      child: JsonView(
        json: log.data,
      ),
    );
  }
}
