import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mindmap/viewmodels/login_viewmodel.dart';
 import 'mocks.mocks.dart'; 

void main() {
  late LoginViewModel loginViewModel;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginViewModel = LoginViewModel();
  });

  group('LoginViewModel Tests', () {
    test('Login should fail with incorrect credentials', () async {
      when(mockAuthRepository.login("wrongUser", "wrongPass"))
          .thenAnswer((_) async => false);

      bool result = await loginViewModel.login("wrongUser", "wrongPass");

      expect(result, false);
      expect(loginViewModel.isLoggedIn, false);
    });

    test('Login should succeed with correct credentials', () async {
      when(mockAuthRepository.login("admin", "password123"))
          .thenAnswer((_) async => true);

      bool result = await loginViewModel.login("admin", "password123");

      expect(result, true);
      expect(loginViewModel.isLoggedIn, true);
    });

    test('isLoading should be true while login is in progress', () async {
      when(mockAuthRepository.login("admin", "password123"))
          .thenAnswer((_) async => true);

      expect(loginViewModel.isLoading, false);

      final future = loginViewModel.login("admin", "password123");

      await Future.delayed(Duration(milliseconds: 10));

      expect(loginViewModel.isLoading, true);

      await future;

      expect(loginViewModel.isLoading, false);
    });
  });
}
