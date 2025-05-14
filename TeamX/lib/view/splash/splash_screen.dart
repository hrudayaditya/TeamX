/// Splash screen that handles initial app loading and authentication check
import 'package:flutter/material.dart';
import 'package:teamx/utils/utils.dart';
import 'package:teamx/view/login/login_screen.dart';
import 'package:teamx/view/fantasy/contest_screen.dart';

/// SplashScreen widget that shows a loading indicator while checking authentication status
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth(); // Check authentication status when screen loads
  }

  /// Checks if user is already authenticated
  ///
  /// This method:
  /// 1. Checks for existing JWT token in secure storage
  /// 2. If token exists, navigates to ContestScreen
  /// 3. If no token, navigates to LoginScreen
  Future<void> _checkAuth() async {
    final jwt = await Utils().secureStorage.read(key: 'jwt');
    if (jwt != null && jwt.isNotEmpty) {
      // User is authenticated, go to main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ContestScreen()),
      );
    } else {
      // User is not authenticated, go to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while checking authentication
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
