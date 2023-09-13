import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_swipe2reply/flutter_swipe2reply.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Swipe2reply widget test', (WidgetTester tester) async {
    // Build a test app with the Swipe2reply widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Swipe2reply(
            onSlided: () {
              // This callback is called when the widget is slid
              // You can add your test logic here
            },
            isRight: true, // Set the direction of the swipe
            child: Container(
                // Your child widget here
                ),
          ),
        ),
      ),
    );

    // Verify that the Swipe2reply widget is initially visible
    expect(find.byIcon(Icons.reply), findsOneWidget);

    // Perform a swipe action on the widget
    await tester.drag(find.byType(Swipe2reply), const Offset(200, 0));
    await tester.pumpAndSettle();

    // Verify that the Swipe2reply widget is still visible after the swipe
    expect(find.byIcon(Icons.reply), findsOneWidget);

    // You can add additional test cases as needed
  });
}
