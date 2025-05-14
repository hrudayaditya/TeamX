import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/view_model/auth_view_model.dart';

void main() {
  test('AuthViewModel methods', () {
    final auth = AuthViewModel();
    auth.setLoading(false);
    auth.setSignUpLoading(false);
    // Call other public methods with dummy data if available
  });
}
