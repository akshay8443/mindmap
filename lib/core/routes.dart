
import 'package:flutter/material.dart';
import 'package:mindmap/views/transaction_history_screen.dart';
import '../views/login_screen.dart';
import '../views/home_screen.dart';
import '../views/wallet_screen.dart';
import '../views/transactions_screen.dart';
import '../views/send_money_screen.dart';


class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const LoginScreen(),
    '/home': (context) => const HomeScreen(),
    '/wallet': (context) => const WalletScreen(), 
    '/transactions': (context) => const TransactionsScreen(),
    
    '/send-money': (context) =>  SendMoneyScreen(),
    '/transaction-history': (context) => const TransactionHistoryScreen(),
  };
}