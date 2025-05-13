import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/view/fantasy/all_accounts_page.dart';
import 'package:teamx/view/fantasy/contest_details.dart';
import 'package:teamx/view/fantasy/contest_screen.dart';
import 'package:teamx/view/fantasy/complete_match_contest_details.dart';
import 'package:teamx/view/fantasy/fantasy_points_system.dart';
import 'package:teamx/view/fantasy/match_fantsay_page.dart';
import 'package:teamx/view/fantasy/preview_players.dart';
import 'package:teamx/view/fantasy/view_all_contest.dart';
import 'package:teamx/view/fantasy/widgets/all_contest_card.dart';
import 'package:teamx/view/fantasy/widgets/my_contest_card.dart';
import 'package:teamx/view/fantasy/widgets/my_teams_card.dart';

void main() {
  testWidgets('AllAccountsPage builds', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AllAccountsPage()));
    expect(find.byType(AllAccountsPage), findsOneWidget);
  });

  testWidgets('ContestScreen builds', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ContestScreen()));
    expect(find.byType(ContestScreen), findsOneWidget);
  });

  testWidgets('ContestDetailsScreen builds', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContestDetailsScreen(id: 'test', contest: const {}),
    ));
    expect(find.byType(ContestDetailsScreen), findsOneWidget);
  });

  testWidgets('CompleteMatchContestDetails builds', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CompleteMatchContestDetails()));
    expect(find.byType(CompleteMatchContestDetails), findsOneWidget);
  });

  testWidgets('FantasyPointsSystem builds', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: FantasyPointsSystem()));
    expect(find.byType(FantasyPointsSystem), findsOneWidget);
  });

  testWidgets('MatchFantasyPage builds', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MatchFantasyPage(contestId: 'test', contest: const {}),
    ));
    expect(find.byType(MatchFantasyPage), findsOneWidget);
  });

  testWidgets('TeamPreview builds', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TeamPreview(selectedPlayers: const [], contest: const {}),
    ));
    expect(find.byType(TeamPreview), findsOneWidget);
  });

  testWidgets('ViewAllContest builds', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ViewAllContest(contest: const [], contestType: 'Test'),
    ));
    expect(find.byType(ViewAllContest), findsOneWidget);
  });

  testWidgets('AllContestCrad builds', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AllContestCrad(
        id: 'id',
        prize: 100,
        entry: 10,
        totalSpots: 10,
        filledSpots: 5,
        isFree: false,
        matchName: 'Match',
        venue: 'Venue',
        date: '2024-05-13',
        status: 'Upcoming',
        teamInfo: const [],
      ),
    ));
    expect(find.byType(AllContestCrad), findsOneWidget);
  });

  testWidgets('MyContestCard builds', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyContestCard(
        id: 'id',
        prize: 100,
        entry: 10,
        totalSpots: 10,
        filledSpots: 5,
        teams: const [],
        isFinished: false,
        contest: const {},
      ),
    ));
    expect(find.byType(MyContestCard), findsOneWidget);
  });

  testWidgets('MyTeamsCard builds', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyTeamsCard(
        teamName: 'Team',
        captain: 'Captain',
        viceCaptain: 'Vice',
        roleStats: const {"WK": 0, "BAT": 0, "AR": 0, "BOWL": 0},
      ),
    ));
    expect(find.byType(MyTeamsCard), findsOneWidget);
  });
}