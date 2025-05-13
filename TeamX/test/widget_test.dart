import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/main.dart';
import 'package:teamx/view/login/login_screen.dart';
import 'package:teamx/view/fantasy/fantasy_points_system.dart';
import 'package:teamx/view/fantasy/wallet_details.dart';
import 'package:teamx/view/fantasy/all_accounts_page.dart';
import 'package:teamx/view/splash/splash_screen.dart';

void main() {
  testWidgets('MyApp builds and contains MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('SplashScreen is home', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(SplashScreen), findsOneWidget);
  });

  testWidgets('routes: /login', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushNamed('/login');
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('routes: /fantasyPointsSystem', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushNamed('/fantasyPointsSystem');
    await tester.pumpAndSettle();
    expect(find.byType(FantasyPointsSystem), findsOneWidget);
  });

testWidgets('WalletPage builds directly', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: WalletPage()));
  expect(find.byType(WalletPage), findsOneWidget);
});


  testWidgets('routes: /allAccounts', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushNamed('/allAccounts');
    await tester.pumpAndSettle();
    expect(find.byType(AllAccountsPage), findsOneWidget);
  });

  test('Basic passing test', () {
    expect(1 + 1, equals(2));
  });

  
}