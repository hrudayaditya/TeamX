import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/main.dart';
import 'package:teamx/view/splash/splash_screen.dart';

void main() {
  testWidgets('App loads and shows logo asset on main screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SplashScreen());
    await tester.pump(); // Only pump a single frame

    // Print all Image widgets for debugging
    tester.widgetList(find.byType(Image)).forEach((widget) {
      print(widget);
    });

    // Check for the logo image asset by file name
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName == 'assets/teamx-logo.png',
      ),
      findsOneWidget,
    );
  });

  testWidgets('App loads and shows Login text on main screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SplashScreen());
    await tester.pump(); // Only pump a single frame

    // Check for the word 'Login' somewhere on the screen
    expect(find.textContaining('Login', findRichText: true), findsWidgets);
  });

  test('Basic passing test', () {
    expect(1 + 1, equals(2));
  });
}