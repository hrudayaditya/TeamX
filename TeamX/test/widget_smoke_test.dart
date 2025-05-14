import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

void main() {
  testWidgets('MyApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('LoginScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('SignUpScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));
    expect(find.byType(SignUpScreen), findsOneWidget);
  });

  testWidgets('ContestScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ContestScreen()));
    expect(find.byType(ContestScreen), findsOneWidget);
  });

  testWidgets('ContestDetailsScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContestDetailsScreen(id: '1', contest: {}),
    ));
    expect(find.byType(ContestDetailsScreen), findsOneWidget);
  });

  testWidgets('AllAccountsPage builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AllAccountsPage()));
    expect(find.byType(AllAccountsPage), findsOneWidget);
  });

  testWidgets('WalletPage builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WalletPage()));
    expect(find.byType(WalletPage), findsOneWidget);
  });

  testWidgets('TeamPreview builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TeamPreview(selectedPlayers: const [], contest: const {}),
    ));
    expect(find.byType(TeamPreview), findsOneWidget);
  });

  testWidgets('CompleteMatchContestDetails builds',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: CompleteMatchContestDetails()));
    expect(find.byType(CompleteMatchContestDetails), findsOneWidget);
  });

  // testWidgets('FantasyPointsSystem builds', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: FantasyPointsSystem()));
  //   expect(find.byType(FantasyPointsSystem), findsOneWidget);
  // });

  testWidgets('ViewAllContest builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ViewAllContest(contest: const [], contestType: 'Test'),
    ));
    expect(find.byType(ViewAllContest), findsOneWidget);
  });

  testWidgets('SplashScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    expect(find.byType(SplashScreen), findsOneWidget);
  });

  // Add more for every widget, page, and even stateless/stateful widgets in /widgets/
  // Example for a stateless widget:
  // testWidgets('AllContestCrad builds', (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //     home: AllContestCrad(
  //       id: '1',
  //       prize: 100,
  //       entry: 10,
  //       totalSpots: 10,
  //       filledSpots: 5,
  //       isFree: false,
  //       matchName: 'Test',
  //       venue: 'Venue',
  //       date: '2025-05-13',
  //       status: 'upcoming',
  //       teamInfo: const [],
  //     ),
  //   ));
  //   expect(find.byType(AllContestCrad), findsOneWidget);
  // });

  // For view_model and utils, call public methods:
  // test('AuthViewModel methods', () {
  //   final auth = AuthViewModel();
  //   auth.setLoading(false);
  //   auth.setSignUpLoading(false);
  //   auth.sendOTP({}, null);
  //   auth.sendFeedback({});
  //   auth.sendReferralCode('code', null);
  //   auth.updateDisplayOrderStatus();
  //   auth.verifyOTP({}, null, false);
  //   auth.verifyReferralCode({}, null);
  //   auth.verifyEmail({}, null);
  //   auth.verifyPhone({}, null);
  //   auth.verifyUser({}, null);
  //   auth.verifyUserWithEmail({}, null);
  //   auth.verifyUserWithPhone({}, null);
  //   auth.verifyUserWithReferral({}, null);
  //   auth.verifyUserWithReferralAndEmail({}, null);
  //   auth.verifyUserWithReferralAndPhone({}, null);
  //   auth.verifyUserWithReferralAndPhoneAndEmail({}, null);
  //   auth.verifyUserWithReferralAndPhoneAndEmailAndOtp({}, null);
  //   auth.verifyUserWithReferralAndPhoneAndEmailAndOtpAndPassword({}, null);
  //   auth.verifyUserWithReferralAndPhoneAndEmailAndOtpAndPasswordAndUsername({}, null);
  //   auth.verifyUserWithReferralAndPhoneAndEmailAndOtpAndPasswordAndUsernameAndPhone({}, null);
  //   // Add more if needed
  // });
}
