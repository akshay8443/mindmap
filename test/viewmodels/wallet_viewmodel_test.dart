import 'package:flutter_test/flutter_test.dart';
import 'package:mindmap/viewmodels/wallet_viewmodel.dart';

void main() {  // ✅ Ensure this is present
  late WalletViewModel walletViewModel;

  setUp(() {
    walletViewModel = WalletViewModel();
  });

  group('WalletViewModel Tests', () {
    test('Should display initial wallet balance correctly', () {
      expect(walletViewModel.balance, 500.00);
    });

    test('Should toggle balance visibility when show/hide is clicked', () {
      expect(walletViewModel.isBalanceVisible, true);

      walletViewModel.toggleBalanceVisibility();
      expect(walletViewModel.isBalanceVisible, false);

      walletViewModel.toggleBalanceVisibility();
      expect(walletViewModel.isBalanceVisible, true);
    });
  });
}
