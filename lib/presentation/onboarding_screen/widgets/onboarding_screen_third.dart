import 'package:flutter/material.dart';

import 'package:elssit/core/utils/image_constant.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingThird extends StatelessWidget {
  const OnboardingThird({super.key});

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
                ImageConstant.onboarding_third_img,
                height: size.height * 0.6,
                //width: size.width * 0.04,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.02,
              ),
              child: Text(
                "Công việc nhẹ nhàng \n Thu nhập ổn định",
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
