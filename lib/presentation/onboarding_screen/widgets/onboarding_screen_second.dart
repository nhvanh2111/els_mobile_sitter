import 'package:flutter/material.dart';

import 'package:elssit/core/utils/image_constant.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingSecond extends StatelessWidget {
  const OnboardingSecond({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                ImageConstant.onboarding_second_img,
                height: size.height * 0.6,
                //width: size.width * 0.04,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.02,
              ),
              child: Text(
                "Dễ dàng tìm kiếm được \n công việc phù hợp",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.height * 0.03,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
