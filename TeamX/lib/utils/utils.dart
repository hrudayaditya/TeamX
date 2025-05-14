import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class Utils {
  final secureStorage = FlutterSecureStorage();

  static formatPrice(double price) => '${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
  Future<void> storeDataSecure(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String> fetchDataSecure(String key) async {
    String? storedValue = await secureStorage.read(key: key);

    // Check if the stored value is null or empty
    if (storedValue == null || storedValue.isEmpty) {
      // You can return a default value or throw an exception, depending on your requirements.
      // Here, we're returning an empty string as a default value.
      return '';
    }

    return storedValue;
  }

  Future<void> deleteDataSecure(String key) async {
    await secureStorage.delete(key: key);
  }

  Future<void> resetDataSecure() async {
    await secureStorage.deleteAll();
  }
}
