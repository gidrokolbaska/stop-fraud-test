import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stop_fraud/consts/constants.dart';
import 'package:stop_fraud/controllers/paywall_controller.dart';

import '../widgets/intro_bottom_button.dart';
import '../widgets/paywall_paginated_view.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key, required this.products});
  final List<ApphudProduct> products;

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  int _selectedIndex = 0;
  final PaywallController _paywallController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        top: false,
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            PaywallPaginatedView(
                controller: controller, paywallController: _paywallController),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ListView.separated(
                  itemCount: widget.products.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var productDetails = widget.products[index].skProduct;

                    return Opacity(
                      opacity: index == _selectedIndex ? 1 : 0.5,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: index == _selectedIndex
                              ? const BorderSide(
                                  color: Constants.kGreenPrimaryColor, width: 2)
                              : BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(0),
                        selectedTileColor: Constants.kMainElementsGrayColor,
                        tileColor:
                            Constants.kMainElementsGrayColor.withOpacity(0.4),
                        title: const Text(
                          'Start 3 Day Free Trial',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            letterSpacing: -0.41,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'After ${productDetails!.price}${productDetails.priceLocale.currencySymbol} per ${productDetails.subscriptionPeriod!.unit.name}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: -0.41,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        selected: index == _selectedIndex,
                        onTap: () {
                          setState(
                            () {
                              _selectedIndex = index;
                            },
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                ),
              ),
            ),
            IntroBottomButton(
                paywallController: _paywallController,
                widget: widget,
                selectedIndex: _selectedIndex),
          ],
        ),
      ),
    );
  }
}

final List<Widget> pages = [
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Start free trial',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Unlimited premium access keeps your phone in control',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Block scam',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Block all kinds of dangerous sites and protect your personal data',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Automatic detection',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Thanks to our large database, we automatically block dangerous sites',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Blacklist and Whitelist',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Set up more flexible access to sites thanks to the whitelist and blacklist',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ],
  ),
];
