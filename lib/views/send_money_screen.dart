import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/transaction_viewmodel.dart';
import '../widgets/custom_button.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  SendMoneyScreenState createState() => SendMoneyScreenState();
}

class SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send Money")),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                       
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              context.read<TransactionViewModel>().validateAmount(value),
                          decoration: InputDecoration(
                            labelText: "Enter Amount",
                            prefixIcon: const Icon(Icons.attach_money),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(height: 15),

                        
                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: "Enter Description",
                            prefixIcon: const Icon(Icons.description),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                
                Consumer<TransactionViewModel>(
                  builder: (context, viewModel, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: "Send Money",
                        icon: Icons.send,
                        isLoading: viewModel.isLoading,
                        backgroundColor: viewModel.isButtonEnabled ? Colors.green : Colors.grey,
                        onPressed: viewModel.isButtonEnabled
                            ? () async {
                                double amount = double.tryParse(_amountController.text) ?? 0.0;
                                String description = _descriptionController.text.trim();
                                bool success = await viewModel.sendMoney(context, amount, description);

                                if (success) {
                                  _amountController.clear();
                                  _descriptionController.clear();
                                }
                                showTransactionBottomSheet(context, success);
                              }
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


void showTransactionBottomSheet(BuildContext context, bool success) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error,
                color: success ? Colors.green : Colors.red,
                size: 80,
              ),
              const SizedBox(height: 10),
              Text(
                success ? "Transaction Successful!" : "Transaction Failed!",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text("OK"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
