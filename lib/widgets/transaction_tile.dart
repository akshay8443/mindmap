import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final double amount;
  final String date;
  final bool isSuccess;

  const TransactionTile({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          isSuccess ? Icons.check_circle : Icons.cancel,
          color: isSuccess ? Colors.green : Colors.red,
        ),
        title: Text(title),
        subtitle: Text(date),
        trailing: Text(
          "₱$amount",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSuccess ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
