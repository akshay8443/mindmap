import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/wallet_viewmodel.dart';
import 'viewmodels/transaction_viewmodel.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => WalletViewModel()),
        
        // Provide http.Client to TransactionViewModel
        ChangeNotifierProvider(
          create: (context) => TransactionViewModel(client: http.Client()), 
        ),
      ],
      child: MaterialApp(
        title: 'Login App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: AppRoutes.routes,
      ),
    );
  }
}
