import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/utils/utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Utils', () {
    test('formatPrice formats correctly', () {
      expect(Utils.formatPrice(12.3456), '12.35');
    });

    test('formatDate formats correctly', () {
      final date = DateTime(2024, 5, 13);
      expect(Utils.formatDate(date), isNotEmpty);
    });

    test('Bid and Ask constructors', () {
      final bid = Bid(price: 10, size: 2.5);
      final ask = Ask(price: 20, size: 1.5);
      expect(bid.price, 10);
      expect(bid.size, 2.5);
      expect(ask.price, 20);
      expect(ask.size, 1.5);
    });

  });
}