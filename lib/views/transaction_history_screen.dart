// views/transaction_history_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/transaction_viewmodel.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  TransactionHistoryScreenState createState() => TransactionHistoryScreenState();
}

class TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionViewModel>(context, listen: false).fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionViewModel = Provider.of<TransactionViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Transaction History")),
      body: transactionViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: transactionViewModel.transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactionViewModel.transactions[index];
                return ListTile(
                  title: Text("Amount: \$${transaction['amount']}"),
                  subtitle: Text("Timestamp: ${transaction['timestamp']}"),
                );
              },
            ),
    );
  }
}

