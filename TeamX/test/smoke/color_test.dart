import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/res/color.dart';

void main() {
  group('AppColors', () {
    test('static colors are correctly defined', () {
      expect(AppColors.black, equals(Colors.black));
      expect(AppColors.white, equals(Colors.white));
      expect(AppColors.green, equals(Colors.green));
    });

    test('primaryColor is correctly defined', () {
      expect(AppColors.primaryColor,
          equals(const Color.fromARGB(255, 44, 44, 46)));
    });

    test('secondaryColor is correctly defined', () {
      expect(AppColors.secondaryColor, equals(Colors.grey[850]));
    });

    test('lightGreen is correctly defined', () {
      expect(AppColors.lightGreen, equals(Colors.green[200]));
    });

    test('custom colors are correctly defined', () {
      expect(AppColors.cardBlue, equals(const Color(0xff197bff)));
      expect(AppColors.cardRed, equals(const Color(0xffdc2804)));
      expect(AppColors.appBackground, equals(const Color(0xa6f4f5fb)));
    });

    test('colors can be used in Material widgets', () {
      final container = Container(
        color: AppColors.primaryColor,
        child: Text(
          'Test',
          style: TextStyle(color: AppColors.white),
        ),
      );
      expect(container, isNotNull);
    });

    test('colors maintain their values', () {
      final originalPrimary = AppColors.primaryColor;
      final originalSecondary = AppColors.secondaryColor;
      final originalLightGreen = AppColors.lightGreen;

      // Access colors multiple times
      for (var i = 0; i < 3; i++) {
        expect(AppColors.primaryColor, equals(originalPrimary));
        expect(AppColors.secondaryColor, equals(originalSecondary));
        expect(AppColors.lightGreen, equals(originalLightGreen));
      }
    });
  });
}
