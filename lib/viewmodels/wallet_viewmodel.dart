import 'package:flutter/material.dart';

class WalletViewModel extends ChangeNotifier {
  double _balance = 500.00;
  bool _isBalanceVisible = true;

  double get balance => _balance;
  bool get isBalanceVisible => _isBalanceVisible;

  /// Toggles wallet balance visibility
  void toggleBalanceVisibility() {
    _isBalanceVisible = !_isBalanceVisible;
    notifyListeners();
  }

  /// Deducts amount if valid
  bool deductBalance(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      notifyListeners();
      debugPrint("Balance Updated: ₹$_balance");
      return true;
    }
    debugPrint("Deduction Failed: Invalid amount or insufficient balance");
    return false;
  }

  /// Adds balance if amount is positive
  void addBalance(double amount) {
    if (amount > 0) {
      _balance += amount;
      notifyListeners();
      debugPrint("Balance Updated: ₹$_balance");
    } else {
      debugPrint("Invalid amount: Cannot add negative or zero balance");
    }
  }
}
