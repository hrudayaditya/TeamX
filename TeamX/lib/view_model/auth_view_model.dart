import 'package:flutter/material.dart';

/// Authentication ViewModel for managing user authentication state and operations
///
/// This class handles:
/// 1. User login and signup
/// 2. Token management
/// 3. User session state
/// 4. Authentication error handling

class AuthViewModelSingleton {
  static final AuthViewModel _instance = AuthViewModel();
  static AuthViewModel get instance => _instance;
}

class AuthViewModel with ChangeNotifier {
  bool loading = false;
  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> sendOTP(dynamic data, BuildContext context) async {
    setLoading(true);
    // Empty implementation
    setLoading(false);
  }

  Future<void> sendFeedback(dynamic data) async {
    // Empty implementation
  }

  Future<void> sendReferralCode(String code, BuildContext context) async {
    setLoading(true);
    // Empty implementation
    setLoading(false);
  }

  Future<void> updateDisplayOrderStatus() async {
    // Empty implementation
  }

  Future<void> verifyOTP(
      dynamic data, BuildContext context, bool redirectToReferScreen) async {
    setLoading(true);
    // Empty implementation
    setLoading(false);
  }

  void resetViewModel() {
    setLoading(false);
    setSignUpLoading(false);
  }
}
