import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/cards/glassmorphism_card.dart';

void main() {
  testWidgets('GlassmorphismCard builds with default values',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Glassmorphism(
            blur: 10,
            opacity: 0.5,
            radius: 5,
            border: 1,
            color: Colors.white,
            child: Text('Test'),
          ),
        ),
      ),
    );

    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('GlassmorphismCard builds with custom values',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Glassmorphism(
            blur: 15,
            opacity: 0.7,
            radius: 10,
            border: 2,
            color: Colors.blue,
            child: Text('Custom Test'),
          ),
        ),
      ),
    );

    expect(find.text('Custom Test'), findsOneWidget);
  });

  testWidgets('GlassmorphismCard handles complex child widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Glassmorphism(
            blur: 10,
            opacity: 0.5,
            radius: 5,
            border: 1,
            color: Colors.white,
            child: Column(
              children: [
                Text('First'),
                Text('Second'),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Button'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('First'), findsOneWidget);
    expect(find.text('Second'), findsOneWidget);
    expect(find.text('Button'), findsOneWidget);
  });
}
