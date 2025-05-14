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
  });

  testWidgets('UpcomingMatches builds with all match types',
      (WidgetTester tester) async {
    final model = MatchListModel();
    model.matches = [];
    model.matchesMap = {};
    model.tournamentSquads = {};

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: Column(
            children: [
              UpcomingMatches(
                context: context,
                matchListModel: model,
                matchType: 'upcoming',
              ),
              UpcomingMatches(
                context: context,
                matchListModel: model,
                matchType: 'live',
              ),
              UpcomingMatches(
                context: context,
                matchListModel: model,
                matchType: 'completed',
              ),
            ],
          ),
        ),
      ),
    ));
  });
}
