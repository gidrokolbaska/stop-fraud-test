import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_fraud/controllers/paywall_controller.dart';
import 'package:stop_fraud/screens/howto_screen.dart';

import '../consts/constants.dart';
import '../widgets/list_element_widget.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final PaywallController _paywallController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Constants.kBackgroundColorGray,
        elevation: 0,
        title: const Text(
          'Settings ',
        ),
        titleTextStyle: const TextStyle(
          fontSize: 28,
          letterSpacing: 0.36,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListElementWidget(
              title: 'Privacy Policy',
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                Get.closeCurrentSnackbar();
                Get.snackbar(
                  'Message',
                  'Open Privacy Policy',
                  snackPosition: SnackPosition.BOTTOM,
                  animationDuration: const Duration(
                    milliseconds: 500,
                  ),
                  duration: const Duration(
                    seconds: 1,
                  ),
                  barBlur: 0,
                  overlayBlur: 0,
                  colorText: Colors.white,
                );
              }),
          const SizedBox(
            height: 10.0,
          ),
          ListElementWidget(
              title: 'Terms of use',
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                Get.closeCurrentSnackbar();
                Get.snackbar(
                  'Message',
                  'Open Terms of use',
                  snackPosition: SnackPosition.BOTTOM,
                  animationDuration: const Duration(
                    milliseconds: 500,
                  ),
                  duration: const Duration(
                    seconds: 1,
                  ),
                  barBlur: 0,
                  overlayBlur: 0,
                  colorText: Colors.white,
                );
              }),
          const SizedBox(
            height: 10.0,
          ),
          ListElementWidget(
            title: 'Restore purchases',
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onTap: () async => _paywallController.restorePurchases(),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ListElementWidget(
            title: 'How to start',
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onTap: () => Get.to(
              () => const HowToScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
