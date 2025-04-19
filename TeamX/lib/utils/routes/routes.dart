import 'package:flutter/material.dart';
import 'package:teamx/utils/routes/routesName.dart';
import 'package:teamx/view/Fantasy/contest_details.dart';
import 'package:teamx/view/Fantasy/contest_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ContestDetailsScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
