// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/main.dart';
import 'package:teamx/view/login/login_screen.dart';
import 'package:teamx/view/login/signup_screen.dart';

void main() {
  // Basic widget test: App loads and shows logo/title
  testWidgets('App shows TeamX logo on login', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    expect(find.byType(Image), findsWidgets); // Logo image
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('App shows Create Account on signup',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));
    expect(find.text('Create Account'), findsOneWidget);
  });

  // Login input validation tests
  testWidgets('Login shows error if fields are empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    final continueBtn = find.byKey(const Key('login_continue_btn'));
    await tester.ensureVisible(continueBtn);
    await tester.tap(continueBtn);
    await tester.pumpAndSettle(); // Wait for SnackBar
    expect(find.text('Email and password are required.'), findsOneWidget);
  });

  testWidgets('Login shows error for invalid email',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await tester.enterText(
        find.byKey(const Key('login_email')), 'invalidemail');
    await tester.enterText(find.byKey(const Key('login_password')), '123456');
    final continueBtn = find.byKey(const Key('login_continue_btn'));
    await tester.ensureVisible(continueBtn);
    await tester.tap(continueBtn);
    await tester.pump();
    expect(find.text('Enter a valid email address.'), findsOneWidget);
  });

  // Signup input validation tests
  testWidgets('Signup shows error if fields are empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));
    final signupBtn = find.byKey(const Key('signup_submit_btn'));
    await tester.ensureVisible(signupBtn);
    await tester.tap(signupBtn);
    await tester.pumpAndSettle();
    expect(find.text('All fields are required.'), findsOneWidget);
  });

  testWidgets('Signup shows error for invalid email',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));
    await tester.enterText(find.byKey(const Key('signup_username')), 'user');
    await tester.enterText(
        find.byKey(const Key('signup_email')), 'invalidemail');
    await tester.enterText(find.byKey(const Key('signup_password')), '123456');
    await tester.enterText(find.byKey(const Key('signup_phone')), '1234567890');
    final signupBtn = find.byKey(const Key('signup_submit_btn'));
    await tester.ensureVisible(signupBtn);
    await tester.tap(signupBtn);
    await tester.pump();
    expect(find.text('Enter a valid email address.'), findsOneWidget);
  });

  testWidgets('Signup shows error for short password',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));
    await tester.enterText(find.byKey(const Key('signup_username')), 'user');
    await tester.enterText(
        find.byKey(const Key('signup_email')), 'test@example.com');
    await tester.enterText(find.byKey(const Key('signup_password')), '123');
    await tester.enterText(find.byKey(const Key('signup_phone')), '1234567890');
    final signupBtn = find.byKey(const Key('signup_submit_btn'));
    await tester.ensureVisible(signupBtn);
    await tester.tap(signupBtn);
    await tester.pump();
    expect(
        find.text('Password must be at least 6 characters.'), findsOneWidget);
  });

  testWidgets('Signup shows error for invalid phone',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));
    await tester.enterText(find.byKey(const Key('signup_username')), 'user');
    await tester.enterText(
        find.byKey(const Key('signup_email')), 'test@example.com');
    await tester.enterText(find.byKey(const Key('signup_password')), '123456');
    await tester.enterText(find.byKey(const Key('signup_phone')), '12345');
    final signupBtn = find.byKey(const Key('signup_submit_btn'));
    await tester.ensureVisible(signupBtn);
    await tester.tap(signupBtn);
    await tester.pump();
    expect(find.text('Enter a valid phone number.'), findsOneWidget);
  });
}
