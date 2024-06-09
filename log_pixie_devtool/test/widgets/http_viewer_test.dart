import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:log_pixie/log_pixie.dart';
import 'package:log_pixie_devtool/src/logs_viewer/widgets/widgets.dart';

void main() {
  testWidgets('HttpViewer Widget Test', (WidgetTester tester) async {
    // Create a fake log data
    final logData = LogData(
      type: LogType.network,
      data: <String, dynamic>{
        'statusCode': 200,
        'path': '/test',
        'method': 'GET',
        'request': <String, dynamic>{
          'method': 'GET',
          'path': '/test',
          'queryParameters': <String, String>{},
          'data': <String, dynamic>{},
          'headers': <String, String>{},
        },
        'headers': <String, String>{},
        'data': <String, dynamic>{},
      },
    );

    // Create the HttpViewer widget
    final widget = MaterialApp(
      home: Scaffold(
        body: HttpViewer(log: logData),
      ),
    );

    // Add the widget to the widget tester
    await tester.pumpWidget(widget);

    // Verify that the HttpViewer widget shows the correct data
    expect(find.text('200'),
        findsOneWidget); // replace '200' with your actual statusCode
    expect(find.text('/test'),
        findsOneWidget); // replace '/test' with your actual path
    expect(find.text('GET'),
        findsOneWidget); // replace 'GET' with your actual method
  });
}
