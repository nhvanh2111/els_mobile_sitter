
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/transaction_models/transaction_data_model.dart';
import '../../../process/bloc/transaction_bloc.dart';

// ignore: must_be_immutable
class TransactionDetailScreen extends StatefulWidget {
  TransactionDetailScreen({Key? key, required this.transactionDataModel})
      : super(key: key);
  TransactionDataModel transactionDataModel;

  @override
  State<TransactionDetailScreen> createState() =>
      // ignore: no_logic_in_create_state
      _TransactionDetailScreenState(transactionDataModel: transactionDataModel);
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  _TransactionDetailScreenState({required this.transactionDataModel});

  TransactionDataModel transactionDataModel;
  final transactionBloc = TransactionBloc();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            bottomOpacity: 0,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: size.height * 0.03,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Padding(
              padding: EdgeInsets.only(left: size.width * 0.12),
              child: const Text(
                "Chi Tiết Giao Dịch",
              ),
            ),
            titleTextStyle: GoogleFonts.roboto(
              fontSize: size.height * 0.024,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
