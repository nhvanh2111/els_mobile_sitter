import 'package:flutter/material.dart';

abstract class WalletEvent{}

class ChoosePaymentMethodToDepositMoneyIntoWalletEvent extends WalletEvent{
  ChoosePaymentMethodToDepositMoneyIntoWalletEvent({required this.context});
  final BuildContext context;
}

class GetBalanceWalletEvent extends WalletEvent{

}