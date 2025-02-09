import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mindmap/viewmodels/wallet_viewmodel.dart';
import 'package:provider/provider.dart';

class TransactionViewModel extends ChangeNotifier {
  final http.Client client;  // Injected client dependency
  List<Map<String, dynamic>> _transactions = [];
  bool _isLoading = false;
  bool _isButtonEnabled = false;

  List<Map<String, dynamic>> get transactions => _transactions;
  bool get isLoading => _isLoading;
  bool get isButtonEnabled => _isButtonEnabled;

  TransactionViewModel({required this.client});

  /// **Fetch Transactions from API**
  Future<void> fetchTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        _transactions = data.map((item) {
          return {
            "title": item["title"] ?? "No Title",
            "amount": (item["id"] * 100).toDouble(), // Mock amount
            "date": "2025-02-09", // Mock date
            "isSuccess": item["id"] % 2 == 0, // Mock success/failure
          };
        }).toList();

        debugPrint("Transactions Fetched: ${_transactions.length}");
      } else {
        debugPrint("Failed to fetch transactions: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching transactions: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// **Enable/Disable Send Money Button**
  void validateAmount(String amount) {
    double parsedAmount = double.tryParse(amount) ?? 0.0;
    _isButtonEnabled = parsedAmount > 0; // Enable button only if amount > 0
    notifyListeners();
  }

  /// **Send money and update transaction history**
 Future<bool> sendMoney(BuildContext context, double amount, String description) async {
  if (amount <= 0) {
    print("❌ Invalid amount");
    return false;
  }

  final walletViewModel = Provider.of<WalletViewModel>(context, listen: false);

  _isLoading = true;
  notifyListeners();

  try {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: jsonEncode({
        "title": description.isEmpty ? "Sent Money" : description,
        "amount": amount,
        "date": DateTime.now().toIso8601String(),
        "isSuccess": true,
      }),
      headers: {"Content-Type": "application/json"},
    );

    _isLoading = false;
    notifyListeners();

    if (response.statusCode == 201) {
      if (walletViewModel.deductBalance(amount)) {
        _transactions.insert(0, {
          "title": description.isEmpty ? "Sent Money" : description,
          "amount": amount,
          "date": DateTime.now().toIso8601String(),
          "isSuccess": true,
        });
        notifyListeners();
        print("✅ Money Sent: ₱$amount, Description: $description");
        return true;
      } else {
        print("❌ Insufficient balance");
        return false;
      }
    } else {
      print("❌ Failed to send money: ${response.statusCode}");
      print("Response Body: ${response.body}");  // Log the response body
      return false;
    }
  } catch (e) {
    _isLoading = false;
    notifyListeners();
    print("❌ Error sending money: $e");
    return false;
  }
}


}
