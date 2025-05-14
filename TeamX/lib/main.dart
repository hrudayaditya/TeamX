// Main entry point for the TeamX Fantasy Sports application
import 'package:flutter/material.dart';
import 'package:teamx/view/fantasy/all_accounts_page.dart';
import 'package:teamx/view/fantasy/fantasy_points_system.dart';
import 'package:teamx/view/fantasy/wallet_details.dart';
import 'package:teamx/view/splash/splash_screen.dart';
import 'package:teamx/view/login/login_screen.dart';

// Application entry point
void main() {
  runApp(const MyApp());
}

/// Root widget of the application
///
/// This widget sets up the MaterialApp with all the necessary routes
/// and initial screen (SplashScreen). It serves as the main configuration
/// point for the app's navigation and theme.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeamX',
      // Define all the named routes in the application
      routes: {
        '/login': (context) => const LoginScreen(),
        '/fantasyPointsSystem': (context) => const FantasyPointsSystem(),
        '/walletPage': (context) => const WalletPage(),
        '/allAccounts': (context) => const AllAccountsPage(),
      },
      // The initial screen shown when the app starts
      home: const SplashScreen(),
    );
  }
}
