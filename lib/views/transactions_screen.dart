import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/transaction_viewmodel.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction History')),
      body: Consumer<TransactionViewModel>(
        builder: (context, transactionViewModel, child) {
          if (transactionViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (transactionViewModel.transactions.isEmpty) {
            return Center(child: Text("No transactions available"));
          }

          return ListView.builder(
            itemCount: transactionViewModel.transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactionViewModel.transactions[index];

              return ListTile(
                title: Text(transaction["title"]),
                subtitle: Text(transaction["date"]),
                trailing: Text("₱${transaction["amount"]}"),
              );
            },
          );
        },
      ),
    );
  }
}
