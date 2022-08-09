import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../consts/constants.dart';
import '../controllers/paywall_controller.dart';
import '../screens/paywall_screen.dart';

class PaywallPaginatedView extends StatelessWidget {
  const PaywallPaginatedView({
    super.key,
    required this.controller,
    required PaywallController paywallController,
  }) : _paywallController = paywallController;

  final PageController controller;
  final PaywallController _paywallController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            child: Image.asset(
              'assets/images/image1.png',
              fit: BoxFit.cover,
              scale: 0.9,
              height: 400,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.6,
            child: SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: ColorTransitionEffect(
                spacing: 4,
                dotHeight: 9,
                dotWidth: 9,
                //type: WormType.thin,
                activeDotColor: Constants.kGreenPrimaryColor,
                dotColor: Colors.white.withOpacity(0.5),
                // strokeWidth: 5,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.08,
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: controller,
              itemCount: pages.length,
              itemBuilder: (_, index) {
                return SizedBox(height: 200, child: pages[index]);
              },
            ),
          ),
          Positioned(
            top: IphoneHasNotch.hasNotch ? 40 : 20,
            right: 8,
            child: IconButton(
              icon: Icon(
                CupertinoIcons.clear_circled_solid,
                color: Colors.white.withOpacity(0.5),
              ),
              onPressed: () {
                if (_paywallController.isFirstLaunch.value == true) {
                  GetStorage().write('isFirstLaunch', false);
                }
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }
}
