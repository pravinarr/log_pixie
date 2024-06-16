import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:log_pixie/log_pixie.dart';
import 'package:log_pixie_devtool/src/logs_viewer/widgets/widgets.dart';

void main() {
  testWidgets('InfoViewer Widget Test', (WidgetTester tester) async {
    // Create a fake log data
    final logData = LogData(
      when: DateTime.now().toString(),
      type: LogType.info, // replace with your actual LogType
      message: 'Test info message',
      data: {}, // replace with your actual data
    );

    // Create the InfoViewer widget
    final widget = MaterialApp(
      home: Scaffold(
        body: InfoViewer(log: logData),
      ),
    );

    // Add the widget to the widget tester
    await tester.pumpWidget(widget);

    // Verify that the InfoViewer widget shows the correct data
    expect(find.text('Test info message'), findsOneWidget);
    expect(find.text('info'),
        findsOneWidget); // replace 'info' with your actual LogType name
  });
}
