import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/view/fantasy/match_fantsay_page.dart';

void main() {
  testWidgets('MatchFantasyPage builds with required parameters',
      (WidgetTester tester) async {
    final contest = {
      'id': '1',
      'prize': 100,
      'entryFee': 10,
      'totalSpots': 100,
      'filledSpots': 50,
      'isFree': false,
      'matchName': 'Test Match',
      'venue': 'Test Venue',
      'date': '2024-03-15',
      'status': 'upcoming',
      'teamInfo': [
        {'name': 'Team A', 'logo': 'url1'},
        {'name': 'Team B', 'logo': 'url2'}
      ],
    };

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MatchFantasyPage(
          contestId: '1',
          contest: contest,
        ),
      ),
    ));

    // Verify that the app bar title is displayed
    expect(find.text('Create Team'), findsOneWidget);

    // Verify that the tab bar is displayed with correct labels
    expect(find.text('WK'), findsOneWidget);
    expect(find.text('BAT'), findsOneWidget);
    expect(find.text('AR'), findsOneWidget);
    expect(find.text('BOWL'), findsOneWidget);

    // Verify that the preview button is displayed
    expect(find.text('PREVIEW'), findsOneWidget);
  });

  testWidgets('MatchFantasyPage handles empty player lists',
      (WidgetTester tester) async {
    final contest = {
      'id': '1',
      'prize': 100,
      'entryFee': 10,
      'totalSpots': 100,
      'filledSpots': 50,
      'isFree': false,
      'matchName': 'Test Match',
      'venue': 'Test Venue',
      'date': '2024-03-15',
      'status': 'upcoming',
      'teamInfo': [
        {'name': 'Team A', 'logo': 'url1'},
        {'name': 'Team B', 'logo': 'url2'}
      ],
    };

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MatchFantasyPage(
          contestId: '1',
          contest: contest,
        ),
      ),
    ));

    // Verify that loading indicator is shown initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('MatchFantasyPage displays correct team info',
      (WidgetTester tester) async {
    final contest = {
      'id': '1',
      'prize': 100,
      'entryFee': 10,
      'totalSpots': 100,
      'filledSpots': 50,
      'isFree': false,
      'matchName': 'Test Match',
      'venue': 'Test Venue',
      'date': '2024-03-15',
      'status': 'upcoming',
      'teamInfo': [
        {'name': 'Team A', 'logo': 'url1'},
        {'name': 'Team B', 'logo': 'url2'}
      ],
    };

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MatchFantasyPage(
          contestId: '1',
          contest: contest,
        ),
      ),
    ));

    // Verify that the team info is displayed
    expect(find.text('Maximum 100 Players from a team'), findsOneWidget);
  });
}
