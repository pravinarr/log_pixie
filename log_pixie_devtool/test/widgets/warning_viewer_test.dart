import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:log_pixie/log_pixie.dart';
import 'package:log_pixie_devtool/src/logs_viewer/widgets/widgets.dart';

void main() {
  testWidgets('WarningViewer Widget Test', (WidgetTester tester) async {
    // Create a fake log data
    final logData = LogData(
      type: LogType.warning, // replace with your actual LogType
      message: 'Test warning message',
      data: {}, // replace with your actual data
    );

    // Create the WarningViewer widget
    final widget = MaterialApp(
      home: Scaffold(
        body: WarningViewer(log: logData),
      ),
    );

    // Add the widget to the widget tester
    await tester.pumpWidget(widget);

    // Verify that the WarningViewer widget shows the correct data
    expect(find.text('Test warning message'), findsOneWidget);
    expect(find.text('warning'),
        findsOneWidget); // replace 'warning' with your actual LogType name
  });
}
