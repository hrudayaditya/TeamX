import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/utils/utils.dart';

void main() {
  group('formatPrice', () {
    test('formats price with 2 decimal places', () {
      expect(Utils.formatPrice(10.0), '10.00');
      expect(Utils.formatPrice(10.123), '10.12');
      expect(Utils.formatPrice(0), '0.00');
      expect(Utils.formatPrice(-10.0), '-10.00');
    });
  });

  group('formatDate', () {
    test('formats date correctly', () {
      final date = DateTime(2024, 3, 15);
      expect(Utils.formatDate(date), '3/15/2024');
    });

    test('handles different date formats', () {
      final date1 = DateTime(2024, 1, 1);
      final date2 = DateTime(2024, 12, 31);
      final date3 = DateTime(2024, 2, 29); // Leap year

      expect(Utils.formatDate(date1), '1/1/2024');
      expect(Utils.formatDate(date2), '12/31/2024');
      expect(Utils.formatDate(date3), '2/29/2024');
    });
  });

  group('Utils instance methods', () {
    test('Utils instance can be created', () {
      final utils = Utils();
      expect(utils, isNotNull);
    });
  });
}
