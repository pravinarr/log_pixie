part of 'widgets.dart';

class LogsViewerProvider extends StatelessWidget {
  const LogsViewerProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogsViewerCubit(),
      child: child,
    );
  }
}
