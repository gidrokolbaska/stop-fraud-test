import 'dart:async';

import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_composite_model.dart';
import 'package:apphud/models/apphud_models/apphud_paywalls.dart';
import 'package:apphud/models/apphud_models/apphud_non_renewing_purchase.dart';

import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:apphud/models/apphud_models/composite/apphud_product_composite.dart';
import 'package:apphud/models/apphud_models/apphud_subscription.dart';
import 'package:apphud/models/apphud_models/composite/apphud_purchase_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../screens/paywall_screen.dart';

class PaywallController extends GetxController implements ApphudListener {
  RxnBool isIntroCompleted = RxnBool(false);
  RxnBool isFirstLaunch = RxnBool(true);
  RxnBool isSubscriptionActive = RxnBool(false);
  List<ApphudProduct>? products;
  ApphudPaywalls? myPaywalls;
  @override
  void onInit() async {
    super.onInit();
    isIntroCompleted.value = GetStorage().read('isIntroCompleted');
    if (GetStorage().read('isFirstLaunch') != null) {
      isFirstLaunch.value = GetStorage().read('isFirstLaunch');
    }
  }

  Future performPurchase(ApphudProduct product) async {
    try {
      ApphudPurchaseResult purchaseResult =
          await Apphud.purchase(product: product);

      if (purchaseResult.subscription != null) {
        isSubscriptionActive.value = purchaseResult.subscription!.isActive;
      }

      if (isSubscriptionActive.value!) {
        // Unlock that great "pro" content
        GetStorage().write('isFirstLaunch', false);

        Get.back();
      }
    } on PlatformException catch (e) {}
  }

  Future restorePurchases() async {
    try {
      Get.closeAllSnackbars();
      Get.dialog(
        const Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ),
        ),
        barrierDismissible: false,
      );

      late ApphudComposite restoreInfo;

      restoreInfo = await Apphud.restorePurchases();

      // ... check restored purchaserInfo to see if entitlement is now active
      Get.back();

      if (restoreInfo.subscriptions.isNotEmpty) {
        final DateTime convertedDateTime = DateTime.fromMillisecondsSinceEpoch(
            restoreInfo.subscriptions[0].expiresAt.toInt() * 1000);

        final String formattedDate =
            DateFormat.yMMMMd().add_Hm().format(convertedDateTime);
        Get.snackbar(
          'Success',
          'Purchases have been restored! \nExpiration date: $formattedDate',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(
            milliseconds: 500,
          ),
          duration: const Duration(
            seconds: 3,
          ),
          barBlur: 0,
          overlayBlur: 0,
          colorText: Colors.white,
        );
      }
    } on PlatformException catch (e) {
      // Error restoring purchases
    }
  }

  Future fetchStatusOfCurrentSubscription(BuildContext context) async {
    try {
      isSubscriptionActive.value = await Apphud.hasActiveSubscription();

      await (Apphud.setListener(listener: this));
    } on PlatformException catch (e) {
      // Error fetching purchaser info
    }
  }

  @override
  Future<void> apphudDidChangeUserID(String userId) async {}

  @override
  Future<void> apphudDidFecthProducts(
    List<ApphudProductComposite> products,
  ) async {}

  @override
  Future<void> paywallsDidFullyLoad(ApphudPaywalls paywalls) async {
    //print(paywalls);
    //add(InitializationEvent.paywallsFetchSuccess(paywalls));
    myPaywalls = paywalls;
    products = myPaywalls!.paywalls[0].products;
    if (!isSubscriptionActive.value!) {
      if (isFirstLaunch.value != null && isFirstLaunch.value!) {
        Get.to(
            () => PaywallScreen(
                  products: products!,
                ),
            fullscreenDialog: true);
      } else {
        return;
      }
    }
  }

  @override
  Future<void> paywallsDidLoad(ApphudPaywalls paywalls) async {}

  @override
  Future<void> apphudNonRenewingPurchasesUpdated(
    List<ApphudNonRenewingPurchase> purchases,
  ) async {}

  @override
  Future<void> apphudSubscriptionsUpdated(
    List<ApphudSubscriptionWrapper> subscriptions,
  ) async {}
}
