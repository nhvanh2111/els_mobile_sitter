import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding:
            EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.07),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.01),
            Image.asset(
              ImageConstant.imgLoading,
              width: size.width * 1,
              height: size.height * 0.6,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              'Đang xử lý',
              style: GoogleFonts.roboto(
                color: ColorConstant.primaryColor,
                fontSize: size.height * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            // Text(
            //   content,
            //   style: GoogleFonts.roboto(
            //     color: Colors.black,
            //     fontSize: size.height * 0.024,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            LoadingAnimationWidget.prograssiveDots(
                color: ColorConstant.primaryColor, size: 100),
          ],
        ),
      ),
    );
  }
}
