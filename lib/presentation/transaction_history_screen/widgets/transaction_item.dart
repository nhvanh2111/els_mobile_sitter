
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/transaction_models/transaction_data_model.dart';
import '../../../core/utils/color_constant.dart';
import '../../../core/utils/my_utils.dart';

Widget transactionItem(BuildContext context, TransactionDataModel data){
  var size = MediaQuery.of(context).size;
  String getTransactionTitle(){
    if(data.type == "RECEIVE"){
      return "Được thanh toán";
    }else{
      return "";
    }
  }
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: Icon(
          Icons.money,
          color: ColorConstant.greenBg,
          size: size.height * 0.03,
        ),
      ),
      SizedBox(
        width: size.width * 0.03,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.38,
            child: Text(
              getTransactionTitle(),
              maxLines: null,
              style: GoogleFonts.roboto(
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          SizedBox(
            width: size.width * 0.38,
            child: Text(
              MyUtils().revertYMD(data.createTime.split("T")[0]),
              maxLines: null,
              style: GoogleFonts.roboto(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        width: size.width * 0.03,
      ),
      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width*0.32,
                child: Text(
                  data.amount,
                  maxLines: null,
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                width: size.width * 0.32,
                child: Text(
                  "Thành công",
                  maxLines: null,
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}