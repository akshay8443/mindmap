import 'package:flutter/material.dart';
import 'package:mindmap/viewmodels/login_viewmodel.dart';
import 'package:mindmap/widgets/balance_widget.dart';
import 'package:provider/provider.dart';
import '../viewmodels/wallet_viewmodel.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key}); // Add const constructor
  
  @override
  Widget build(BuildContext context) {
      final loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
       appBar: AppBar(
        title: const Text("Wallet"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              loginViewModel.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      
      
      
      
      body: Consumer<WalletViewModel>(
        builder: (context, walletViewModel, child) {
          return Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   walletViewModel.isHidden ? "₱******" : "₱${walletViewModel.balance}",
              //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              // ),
              // IconButton(
              //   icon: Icon(walletViewModel.isHidden ? Icons.visibility : Icons.visibility_off),
              //   onPressed: walletViewModel.toggleBalanceVisibility,
              // ),
              const BalanceWidget(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/send-money');
                },
                child: Text("Send Money"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/transactions');
                },
                child: Text("View Transactions"),
              ),
            ],
          );
        },
      ),
    );
  }
}
