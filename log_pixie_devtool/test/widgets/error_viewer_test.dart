import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:log_pixie/log_pixie.dart';
import 'package:log_pixie_devtool/src/logs_viewer/widgets/widgets.dart';

void main() {
  testWidgets('ErrorViewer Widget Test', (WidgetTester tester) async {
    // Create a fake log data
    final logData = LogData(
      type: LogType.error, // replace with your actual LogType
      message: 'Test error message',
      data: {}, // replace with your actual data
    );

    // Create the ErrorViewer widget
    final widget = MaterialApp(
      home: Scaffold(
        body: ErrorViewer(log: logData),
      ),
    );

    // Add the widget to the widget tester
    await tester.pumpWidget(widget);

    // Verify that the ErrorViewer widget shows the correct data
    expect(find.text('Test error message'), findsOneWidget);
    expect(find.text('error'),
        findsOneWidget); // replace 'error' with your actual LogType name
  });
}
