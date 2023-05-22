import '../../core/models/transaction_models/transaction_data_model.dart';

abstract class TransactionState{}
class OtherTransactionState extends TransactionState{}
class GetAllTransactionState extends TransactionState{
  GetAllTransactionState({required this.listTransaction});
  List<TransactionDataModel> listTransaction;
}