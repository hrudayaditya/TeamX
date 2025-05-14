import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/res/color.dart';

void main() {
  test('AppColors static fields', () {
    // Just access all static fields to ensure coverage
    AppColors.black;
    AppColors.white;
    AppColors.green;
    AppColors.primaryColor;
    AppColors.secondaryColor;
    AppColors.lightGreen;
    AppColors.cardBlue;
    AppColors.cardRed;
    AppColors.appBackground;
  });
}
