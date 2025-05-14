import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import all your files here
import 'package:teamx/main.dart';
import 'package:teamx/view/login/login_screen.dart';
import 'package:teamx/view/login/signup_screen.dart';
import 'package:teamx/view/fantasy/contest_screen.dart';
import 'package:teamx/view/fantasy/contest_details.dart';
import 'package:teamx/view/fantasy/all_accounts_page.dart';
import 'package:teamx/view/fantasy/wallet_details.dart';
import 'package:teamx/view/fantasy/preview_players.dart';
import 'package:teamx/view/fantasy/complete_match_contest_details.dart';
import 'package:teamx/view/fantasy/fantasy_points_system.dart';
import 'package:teamx/view/fantasy/view_all_contest.dart';
import 'package:teamx/view/home/homepage.dart';
import 'package:teamx/view/splash/splash_screen.dart';
import 'package:teamx/view_model/auth_view_model.dart';
import 'package:teamx/utils/utils.dart';
// ...import all widgets and models

void main() {
  // Main app
  testWidgets('MyApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });

  // Login
  testWidgets('LoginScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await tester.enterText(find.byKey(const Key('login_email')), 'a@b.com');
    await tester.enterText(find.byKey(const Key('login_password')), '123456');
    await tester.tap(find.byKey(const Key('login_continue_btn')));
    await tester.pumpAndSettle();
  });

  // Signup
  testWidgets('SignUpScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));
    await tester.enterText(find.byKey(const Key('signup_username')), 'user');
    await tester.enterText(find.byKey(const Key('signup_email')), 'a@b.com');
    await tester.enterText(find.byKey(const Key('signup_password')), '123456');
    await tester.enterText(find.byKey(const Key('signup_phone')), '1234567890');
    await tester.tap(find.byKey(const Key('signup_submit_btn')));
    await tester.pumpAndSettle();
  });

  // Fantasy screens
  testWidgets('ContestScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ContestScreen()));
  });

  testWidgets('ContestDetailsScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContestDetailsScreen(id: '1', contest: {}),
    ));
  });

  testWidgets('AllAccountsPage builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AllAccountsPage()));
  });

  testWidgets('WalletPage builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WalletPage()));
  });

  testWidgets('TeamPreview builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TeamPreview(selectedPlayers: const [], contest: const {}),
    ));
  });

  testWidgets('CompleteMatchContestDetails builds',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: CompleteMatchContestDetails()));
  });

  testWidgets('FantasyPointsSystem builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: FantasyPointsSystem()));
  });

  testWidgets('ViewAllContest builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ViewAllContest(contest: const [], contestType: 'Test'),
    ));
  });

  testWidgets('SplashScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
  });

  // Utils and ViewModels
  test('Utils and AuthViewModel', () {
    final utils = Utils();
    utils.resetDataSecure();
    // ...call all public methods

    final auth = AuthViewModel();
    auth.setLoading(false);
    auth.setSignUpLoading(false);
    // ...call all public methods
  });

  // Repeat for every widget, model, and utility class in your codebase!
}
