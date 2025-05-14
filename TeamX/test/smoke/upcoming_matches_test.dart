import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/widgets/upcoming_matches.dart';
import 'package:teamx/model/match_model.dart';

void main() {
  testWidgets('UpcomingMatches builds with empty matches',
      (WidgetTester tester) async {
    final model = MatchListModel();
    model.matches = [];
    model.matchesMap = {};
    model.tournamentSquads = {};

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: UpcomingMatches(
            context: context,
            matchListModel: model,
            matchType: 'upcoming',
          ),
        ),
      ),
    ));

    // Verify that the "no upcoming matches" message is displayed
    expect(find.text('There are no upcoming matches, cricket is on a break'),
        findsOneWidget);
  });

  testWidgets('UpcomingMatches builds with live matches',
      (WidgetTester tester) async {
    final model = MatchListModel();
    model.matches = [];
    model.matchesMap = {};
    model.tournamentSquads = {};

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: UpcomingMatches(
            context: context,
            matchListModel: model,
            matchType: 'live',
          ),
        ),
      ),
    ));

    // Verify that the "no live matches" message is displayed
    expect(find.text('No live matches!! Take trades on upcoming matches'),
        findsOneWidget);
  });

  testWidgets('UpcomingMatches builds with completed matches',
      (WidgetTester tester) async {
    final model = MatchListModel();
    model.matches = [];
    model.matchesMap = {};
    model.tournamentSquads = {};

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: UpcomingMatches(
            context: context,
            matchListModel: model,
            matchType: 'completed',
          ),
        ),
      ),
    ));

    // Verify that the "check out live and upcoming matches" message is displayed
    expect(find.text('Check out live and upcoming matches'), findsOneWidget);
  });

  testWidgets('UpcomingMatches handles match with null batting team',
      (WidgetTester tester) async {
    final model = MatchListModel();
    model.matches = [
      Matches(
        mid: 1,
        teams: {},
        startTime: '2024-03-15T10:00:00Z',
        endTime: '2024-03-15T14:00:00Z',
        status: 1,
        tournament: 'Test Tournament',
        tournamentAbbr: 'TT',
      ),
    ];
    model.matchesMap = {1: model.matches[0]};
    model.tournamentSquads = {};

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: UpcomingMatches(
            context: context,
            matchListModel: model,
            matchType: 'upcoming',
          ),
        ),
      ),
    ));

    // Verify that the match card is not displayed
    expect(find.byType(Container),
        findsNWidgets(1)); // Only the Scaffold container
  });

  testWidgets('UpcomingMatches displays match card correctly',
      (WidgetTester tester) async {
    final model = MatchListModel();
    final team1 = Team(
      id: 1,
      name: 'Team A',
      abbreviation: 'TA',
      logo: 'url1',
      players: {},
    );
    final team2 = Team(
      id: 2,
      name: 'Team B',
      abbreviation: 'TB',
      logo: 'url2',
      players: {},
    );
    model.matches = [
      Matches(
        mid: 1,
        teams: {1: team1, 2: team2},
        startTime: '2024-03-15T10:00:00Z',
        endTime: '2024-03-15T14:00:00Z',
        status: 1,
        tournament: 'Test Tournament',
        tournamentAbbr: 'TT',
      ),
    ];
    model.matchesMap = {1: model.matches[0]};
    model.tournamentSquads = {};

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: UpcomingMatches(
            context: context,
            matchListModel: model,
            matchType: 'upcoming',
          ),
        ),
      ),
    ));

    // Verify that the tournament abbreviation is displayed
    expect(find.text('TT'), findsOneWidget);

    // Verify that the team abbreviations are displayed
    expect(find.text('TA'), findsOneWidget);
    expect(find.text('TB'), findsOneWidget);
  });
}
