import 'package:flutter/material.dart';
import 'package:teamx/view/fantasy/all_accounts_page.dart';
import 'package:teamx/view/fantasy/fantasy_points_system.dart';
import 'package:teamx/view/fantasy/wallet_details.dart';
import 'package:teamx/view/splash/splash_screen.dart';
import 'package:teamx/view/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeamX',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/fantasyPointsSystem': (context) => const FantasyPointsSystem(),
        '/walletPage': (context) => const WalletPage(),
        '/allAccounts': (context) => const AllAccountsPage(),
      },
      home: const SplashScreen(),
    );
  }
}