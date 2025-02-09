
import 'package:flutter/material.dart';
import '../data/repositories/auth_repository.dart';
import '../models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool _isLoading = false;
  User? _user;

  bool get isLoading => _isLoading;
  User? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    bool success = await _authRepository.login(username, password);
    if (success) {
      _user = User(username);
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}