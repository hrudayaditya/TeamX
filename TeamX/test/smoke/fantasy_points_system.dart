import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/view/fantasy/fantasy_points_system.dart';

void main() {
  testWidgets('FantasyPointsSystem builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: FantasyPointsSystem()));
    // Optionally, interact with tabs and floating action button for more coverage
    await tester.tap(find.byType(Tab));
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();
  });

  testWidgets('ListOfPointsCard builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListOfPointsCard(pointsList: [
          {'Type': 'Run', 'Points': '+1 PTS'},
          {'Type': 'Four Bonus', 'Points': '+2 PTS'},
        ]),
      ),
    ));
  });
}