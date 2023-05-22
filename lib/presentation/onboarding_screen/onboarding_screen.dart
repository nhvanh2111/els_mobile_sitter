import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intro_slider/intro_slider.dart';

import '../../fire_base/login_with_google_nav.dart';
import '../../core/utils/color_constant.dart';

import 'package:elssit/presentation/onboarding_screen/widgets/onboarding_button.dart';
import 'package:elssit/presentation/onboarding_screen/widgets/onboarding_screen_first.dart';
import 'package:elssit/presentation/onboarding_screen/widgets/onboarding_screen_second.dart';
import 'package:elssit/presentation/onboarding_screen/widgets/onboarding_screen_third.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _elsBox = Hive.box('elsBox');

  @override
  void initState() {
    super.initState();
    _elsBox.put('isOpened', true);
  }

  Widget inputContent(index) {
    if (index == 0) {
      return const OnboardingFirst();
    } else if (index == 1) {
      return const OnboardingSecond();
    } else {
      return const OnboardingThird();
    }
  }

  List<Widget> renderListCustomTabs() {
    return List.generate(3, (index) => inputContent(index));
  }

  @override
  Widget build(BuildContext context) {
    void onDonePress() {
      Navigator.pushNamed(context, '/loginWithGoogleNav');
    }

    return Container(
      margin: const EdgeInsets.all(0),
      child: IntroSlider(
        renderNextBtn: renderNextBtn(),
        renderSkipBtn: renderSkipBtn(context),
        renderDoneBtn: renderDoneBtn(context),
        listCustomTabs: renderListCustomTabs(),
        onDonePress: onDonePress,
        typeDotAnimation: DotSliderAnimation.SIZE_TRANSITION,
        sizeDot: 10,
        colorDot: ColorConstant.primaryColor,
      ),
    );
  }
}
