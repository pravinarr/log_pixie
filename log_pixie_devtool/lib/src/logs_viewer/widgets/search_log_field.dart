part of 'widgets.dart';

class SearchLogField extends StatefulWidget {
  const SearchLogField({super.key});

  @override
  State<SearchLogField> createState() => _SearchLogFieldState();
}

class _SearchLogFieldState extends State<SearchLogField> {
  final _controller = TextEditingController();

  void _onSubmitted() {
    context.read<LogsViewerCubit>().search(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (_) => _onSubmitted(),
      decoration: InputDecoration(
        hintText: 'Search logs',
        border: const UnderlineInputBorder(),
        suffix: IconButton(
          onPressed: _onSubmitted,
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
