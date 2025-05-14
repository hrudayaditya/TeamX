import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/res/app_url.dart';

void main() {
  test('AppUrl static fields', () {
    // Access all static fields to ensure coverage
    AppUrl.baseUrl;
    AppUrl.loginEndPint;
    AppUrl.signUpEndPint;
    AppUrl.wallet;
    AppUrl.accounts;
    AppUrl.listContest;
    AppUrl.getPlayers;
    AppUrl.createTeam;
    AppUrl.reduceAmount;
    AppUrl.viewTeam;
    AppUrl.getPoints;
  });
}
