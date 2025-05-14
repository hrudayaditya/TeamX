import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/view/fantasy/wallet_details.dart';
import 'package:teamx/utils/utils.dart';

void main() {
  group('WalletPage', () {
    testWidgets('displays wallet balance and add money button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WalletPage(),
        ),
      );

      // Verify initial UI elements
      expect(find.text('Wallet Balance'), findsOneWidget);
      expect(find.text('₹0'), findsOneWidget);
      expect(find.text('Add Money'), findsOneWidget);
    });

    testWidgets('shows add money dialog when button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WalletPage(),
        ),
      );

      // Tap add money button
      await tester.tap(find.text('Add Money'));
      await tester.pumpAndSettle();

      // Verify dialog elements
      expect(find.text('Add Money'),
          findsNWidgets(2)); // One in button, one in dialog
      expect(find.text('Enter Amount'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('validates amount input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WalletPage(),
        ),
      );

      // Open add money dialog
      await tester.tap(find.text('Add Money'));
      await tester.pumpAndSettle();

      // Try to submit empty amount
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter an amount'), findsOneWidget);

      // Enter invalid amount
      await tester.enterText(find.byType(TextFormField), '-100');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid amount'), findsOneWidget);

      // Enter valid amount
      await tester.enterText(find.byType(TextFormField), '100');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid amount'), findsNothing);
    });

    testWidgets('shows OTP dialog after valid amount entry',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WalletPage(),
        ),
      );

      // Open add money dialog and enter valid amount
      await tester.tap(find.text('Add Money'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), '100');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Verify OTP dialog elements
      expect(find.text('Enter OTP'), findsOneWidget);
      expect(find.text('OTP has been sent to your email'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Verify'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('validates OTP input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WalletPage(),
        ),
      );

      // Open add money dialog and enter valid amount
      await tester.tap(find.text('Add Money'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), '100');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Try to submit empty OTP
      await tester.tap(find.text('Verify'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter OTP'), findsOneWidget);

      // Enter invalid OTP
      await tester.enterText(find.byType(TextFormField), '12345');
      await tester.tap(find.text('Verify'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid OTP'), findsOneWidget);

      // Enter valid OTP
      await tester.enterText(find.byType(TextFormField), '123456');
      await tester.tap(find.text('Verify'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid OTP'), findsNothing);
    });

    testWidgets('shows loading indicator during operations',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WalletPage(),
        ),
      );

      // Verify initial state
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Open add money dialog
      await tester.tap(find.text('Add Money'));
      await tester.pumpAndSettle();

      // Enter valid amount
      await tester.enterText(find.byType(TextFormField), '100');
      await tester.tap(find.text('Add'));
      await tester.pump();

      // Verify loading indicator appears
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('handles error states', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WalletPage(),
        ),
      );

      // Open add money dialog
      await tester.tap(find.text('Add Money'));
      await tester.pumpAndSettle();

      // Enter valid amount
      await tester.enterText(find.byType(TextFormField), '100');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Enter valid OTP
      await tester.enterText(find.byType(TextFormField), '123456');
      await tester.tap(find.text('Verify'));
      await tester.pumpAndSettle();

      // Verify error message appears
      expect(find.text('Failed to verify OTP'), findsOneWidget);
    });

    testWidgets('updates wallet balance after successful transaction',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WalletPage(),
        ),
      );

      // Verify initial balance
      expect(find.text('₹0'), findsOneWidget);

      // Open add money dialog
      await tester.tap(find.text('Add Money'));
      await tester.pumpAndSettle();

      // Enter valid amount
      await tester.enterText(find.byType(TextFormField), '100');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Enter valid OTP
      await tester.enterText(find.byType(TextFormField), '123456');
      await tester.tap(find.text('Verify'));
      await tester.pumpAndSettle();

      // Verify balance is updated
      expect(find.text('₹100'), findsOneWidget);
    });
  });
}
