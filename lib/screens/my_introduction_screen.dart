import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:stop_fraud/consts/constants.dart';

import '../widgets/custom_intro_widget.dart';

class CustomIntroductionScreen extends StatelessWidget {
  const CustomIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIntroWidget(
      pages: listPagesViewModel,

      showDoneButton: false,
      isBottomSafeArea: true,
      isTopSafeArea: false,
      showBackButton: true,
      showGlobalFooter: true,
      backStyle: IconButton.styleFrom(
        foregroundColor: Colors.white,
        highlightColor: Colors.transparent,
      ),
      skipStyle: TextButton.styleFrom(
        foregroundColor: Colors.white.withOpacity(
          0.5,
        ),
        textStyle: const TextStyle(fontSize: 13, letterSpacing: -0.08),
      ),
      back: const Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 24.0,
      ),

      dotsDecorator: DotsDecorator(
        spacing: const EdgeInsets.all(4),
        activeColor: Constants.kGreenPrimaryColor,
        color: Colors.white.withOpacity(0.5),
      ),

      showSkipButton: false,
      next: const Icon(Icons.next_plan),
      //isTopSafeArea: true,
      skip: const Text("Skip"),

      globalBackgroundColor: Constants.kBackgroundColorGray,
      //globalFooter: Text('hello'),
      controlsPosition: Position(
          left: 0, right: 0, bottom: MediaQuery.of(context).size.height / 7.sp),
    );
  }
}

final List<PageViewModel> listPagesViewModel = [
  PageViewModel(
    title: "Don't fall for scammers",
    body:
        "Block fraudulent websites, do not let yourself be deceived by scammers and take over your personal data",
    image: Container(
      color: Constants.kBackgroundColorDark,
      child: Center(
        child: Image.asset(
          'assets/images/dollar_hook.png',
          //scale: 0.9,
          width: 300.w,
          height: 300.h,
        ),
      ),
    ),
    decoration: PageDecoration(
      imageFlex: 4,
      bodyFlex: 3,
      imagePadding: EdgeInsets.only(bottom: 10.0.sp),
      titlePadding: EdgeInsets.only(top: 7.0.sp, bottom: 5.sp),
      bodyPadding: EdgeInsets.all(10.sp),
      titleTextStyle: TextStyle(
        fontSize: 35.0.sp,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 17.0.sp,
        color: Colors.white.withOpacity(0.5),
      ),
    ),
  ),
  PageViewModel(
    title: "Automatic detection",
    body:
        "Every time we replenish our database of scam sites and protect you from these sites",
    image: Container(
      color: Constants.kBackgroundColorDark,
      child: Center(
        child: Image.asset(
          'assets/images/lupa.png',
          width: 300.w,
          height: 300.h,
        ),
      ),
    ),
    decoration: PageDecoration(
      imageFlex: 4,
      bodyFlex: 3,
      imagePadding: EdgeInsets.only(bottom: 10.0.sp),
      titlePadding: EdgeInsets.only(top: 7.0.sp, bottom: 5.sp),
      bodyPadding: EdgeInsets.all(10.sp),
      titleTextStyle: TextStyle(
        fontSize: 40.0.sp,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 17.0.sp,
        color: Colors.white.withOpacity(0.5),
      ),
    ),
  ),
  PageViewModel(
    title: "Automatic detection",
    body:
        "Every time we replenish our database of scam sites and protect you from these sites",
    image: Container(
      color: Constants.kBackgroundColorDark,
      child: Center(
        child: Image.asset(
          'assets/images/shield.png',
          width: 300.w,
          height: 300.h,
        ),
      ),
    ),
    decoration: PageDecoration(
      imageFlex: 4,
      bodyFlex: 3,
      imagePadding: EdgeInsets.only(bottom: 10.0.sp),
      titlePadding: EdgeInsets.only(top: 7.0.sp, bottom: 5.sp),
      bodyPadding: EdgeInsets.all(10.sp),
      titleTextStyle: TextStyle(
        fontSize: 40.0.sp,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 17.0.sp,
        color: Colors.white.withOpacity(0.5),
      ),
    ),
  ),
];
