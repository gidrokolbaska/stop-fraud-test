import 'package:flutter/material.dart';

import '../consts/constants.dart';
import '../controllers/paywall_controller.dart';
import '../screens/paywall_screen.dart';

class IntroBottomButton extends StatelessWidget {
  const IntroBottomButton({
    super.key,
    required PaywallController paywallController,
    required this.widget,
    required int selectedIndex,
  })  : _paywallController = paywallController,
        _selectedIndex = selectedIndex;

  final PaywallController _paywallController;
  final PaywallScreen widget;
  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 0 : 10),
      child: Container(
        constraints: const BoxConstraints(minHeight: 67),
        width: double.infinity,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Constants.kGreenLightColor,
              Constants.kGreenDarkColor,
            ],
          ),
          shadows: const [
            BoxShadow(
              offset: Offset(0, 9),
              blurRadius: 32,
              spreadRadius: 0,
              color: Constants.kGreenShadowColor,
            )
          ],
        ),
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'Start my 3-day free trial',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.36,
            ),
          ),
          onPressed: () async {
            await _paywallController.performPurchase(
              widget.products[_selectedIndex],
            );
          },
        ),
      ),
    );
  }
}
