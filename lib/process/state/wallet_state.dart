abstract class WalletState{}

class GetBalanceWalletState extends WalletState{
  GetBalanceWalletState({required this.balance});
  final String balance;
}