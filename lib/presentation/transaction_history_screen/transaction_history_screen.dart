
import 'package:elssit/presentation/transaction_history_screen/widgets/transaction_detail.dart';
import 'package:elssit/presentation/transaction_history_screen/widgets/transaction_item.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/models/transaction_models/transaction_data_model.dart';
import '../../core/utils/color_constant.dart';
import '../../process/bloc/transaction_bloc.dart';
import '../../process/event/transaction_event.dart';
import '../../process/state/transaction_state.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final transactionBloc = TransactionBloc();
  List<TransactionDataModel> listTransaction = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactionBloc.eventController.sink.add(GetAllTransactionEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: transactionBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is GetAllTransactionState) {
              listTransaction =
                  (snapshot.data as GetAllTransactionState).listTransaction;
              transactionBloc.eventController.sink.add(OtherTransactionEvent());
            }
          }
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
                  "Lịch Sử Giao Dịch",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            body: Material(
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(size.width * 0.03),
                        margin: EdgeInsets.only(
                          top: size.height * 0.03,
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(size.height * 0.02),
                        ),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(0),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionDetailScreen(
                                              transactionDataModel:
                                                  listTransaction[index]),
                                    ));
                              },
                              child: transactionItem(
                                  context, listTransaction[index]),
                            );
                          },
                          separatorBuilder: (context, index) => Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                height: 1,
                                width: size.width,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                            ],
                          ),
                          itemCount: listTransaction.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
