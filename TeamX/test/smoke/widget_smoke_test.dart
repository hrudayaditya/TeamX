import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/widgets/timer_match_card.dart';
import 'package:teamx/widgets/upcoming_matches.dart';
import 'package:teamx/cards/glassmorphism_card.dart';
import 'package:teamx/view/fantasy/fantasy_points_system.dart';
import 'package:teamx/view/fantasy/complete_match_contest_details.dart';
import 'package:teamx/view/fantasy/preview_players.dart';
import 'package:teamx/view/fantasy/contest_screen.dart';
import 'package:teamx/view/fantasy/contest_details.dart';
import 'package:teamx/view/fantasy/match_fantsay_page.dart';
import 'package:teamx/view/fantasy/widgets/all_contest_card.dart';
import 'package:teamx/view/fantasy/widgets/my_contest_card.dart';
import 'package:teamx/view/fantasy/widgets/my_teams_card.dart';
import 'package:teamx/view/fantasy/widgets/team_and_player_info.dart';
import 'package:teamx/view/fantasy/view_all_contest.dart';
import 'package:teamx/model/match_model.dart';
import 'package:teamx/widgets/toggle_switch_reminder.dart';

void main() {
  testWidgets('UpcomingMatches builds', (WidgetTester tester) async {
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
  });

  // testWidgets('FantasyPointsSystem builds', (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: SizedBox(
  //           width: 800, // Increased width to prevent overflow
  //           child: FantasyPointsSystem(),
  //         ),
  //       ),
  //     ),
  //   ));
  // });

  testWidgets('CompleteMatchContestDetails builds',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CompleteMatchContestDetails(),
      ),
    ));
  });

  testWidgets('TeamPreview builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TeamPreview(selectedPlayers: const [], contest: const {}),
      ),
    ));
  });

  testWidgets('ContestScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ContestScreen(),
      ),
    ));
  });

  testWidgets('ContestDetailsScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ContestDetailsScreen(id: '1', contest: {}),
      ),
    ));
  });

  // testWidgets('MatchFantasyPage builds', (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: SizedBox(
  //           width: 800, // Increased width to prevent overflow
  //           child: MatchFantasyPage(contestId: '1', contest: const {}),
  //         ),
  //       ),
  //     ),
  //   ));
  // });

  testWidgets('AllContestCrad builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 800, // Increased width to prevent overflow
            child: AllContestCrad(
              id: '1',
              prize: 100,
              entry: 10,
              totalSpots: 10,
              filledSpots: 5,
              isFree: false,
              matchName: 'Test',
              venue: 'Venue',
              date: '2025-05-13',
              status: 'upcoming',
              teamInfo: const [],
              onDelete: null,
            ),
          ),
        ),
      ),
    ));
  });

  testWidgets('MyContestCard builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 800, // Increased width to prevent overflow
            child: MyContestCard(
              id: '1',
              prize: 100,
              entry: 10,
              totalSpots: 10,
              filledSpots: 5,
              teams: const [],
              isFinished: false,
              contest: const {},
            ),
          ),
        ),
      ),
    ));
  });

  testWidgets('MyTeamsCard builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 800, // Increased width to prevent overflow
            child: MyTeamsCard(
              teamName: 'Team 1',
              captain: 'Captain',
              viceCaptain: 'Vice',
              roleStats: const {'WK': 1, 'BAT': 2, 'AR': 3, 'BOWL': 5},
            ),
          ),
        ),
      ),
    ));
  });

  testWidgets('TeamAndPlayerInfo builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 800, // Increased width to prevent overflow
            child: TeamAndPlayerInfo(
              teamInfo: const [],
              selectedPlayersCount: 5,
              maxPlayers: 11,
              team1Count: 3,
              team2Count: 2,
              creditsLeft: 90.0,
            ),
          ),
        ),
      ),
    ));
  });

  testWidgets('ViewAllContest builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ViewAllContest(contest: const [], contestType: 'Test'),
      ),
    ));
  });

  testWidgets('CountdownWidget builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CountdownWidget(
          duration: const Duration(seconds: 10),
          startTime: DateTime.now(),
        ),
      ),
    ));
  });

  testWidgets('SwitchScreen builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 800, // Increased width to prevent overflow
            child: SwitchScreen(),
          ),
        ),
      ),
    ));
  });
}
