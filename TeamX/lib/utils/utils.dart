import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

/// Utility functions for the TeamX Fantasy Sports application
///
/// This class provides helper methods for:
/// 1. Secure storage operations
/// 2. Data fetching and validation
/// 3. Common UI operations
/// 4. Error handling

class Utils {
  /// Secure storage instance for storing sensitive data
  final secureStorage = const FlutterSecureStorage();

  /// Fetches data from secure storage
  ///
  /// Parameters:
  /// - key: The key to fetch data for
  ///
  /// Returns:
  /// - The stored value or null if not found
  Future<String?> fetchDataSecure(String key) async {
    return await secureStorage.read(key: key);
  }

  /// Stores data in secure storage
  ///
  /// Parameters:
  /// - key: The key to store data under
  /// - value: The value to store
  Future<void> storeDataSecure(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  /// Deletes data from secure storage
  ///
  /// Parameters:
  /// - key: The key to delete data for
  Future<void> deleteDataSecure(String key) async {
    await secureStorage.delete(key: key);
  }

  /// Clears all data from secure storage
  Future<void> clearAllDataSecure() async {
    await secureStorage.deleteAll();
  }

  /// Validates email format
  ///
  /// Parameters:
  /// - email: The email to validate
  ///
  /// Returns:
  /// - true if email is valid, false otherwise
  bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  /// Shows a snackbar message
  ///
  /// Parameters:
  /// - context: The build context
  /// - message: The message to display
  /// - duration: How long to show the message (default: 2 seconds)
  void showSnackBar(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }

  /// Formats currency amount
  ///
  /// Parameters:
  /// - amount: The amount to format
  ///
  /// Returns:
  /// - Formatted currency string
  String formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  /// Formats date to readable string
  ///
  /// Parameters:
  /// - date: The date to format
  ///
  /// Returns:
  /// - Formatted date string
  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Handles API errors
  ///
  /// Parameters:
  /// - error: The error to handle
  /// - context: The build context
  void handleApiError(dynamic error, BuildContext context) {
    String message = 'An error occurred';
    if (error is Exception) {
      message = error.toString();
    }
    showSnackBar(context, message);
  }
}
