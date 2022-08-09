import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:stop_fraud/controllers/whitelist_blacklist_controller.dart';
import 'package:stop_fraud/screens/paywall_screen.dart';

import 'package:stop_fraud/widgets/list_element_widget.dart';

import '../consts/constants.dart';
import '../controllers/paywall_controller.dart';
import '../widgets/elements_listview.dart';

class WhitelistScreen extends StatefulWidget {
  const WhitelistScreen({super.key});

  @override
  State<WhitelistScreen> createState() => _WhitelistScreenState();
}

class _WhitelistScreenState extends State<WhitelistScreen> {
  final BlacklistWhitelistController _blacklistWhitelistController = Get.find();
  late TextEditingController _textEditingController;
  final PaywallController _paywallController = Get.find();
  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Constants.kBackgroundColorGray,
        elevation: 0,
        title: const Text(
          'Whitelist',
        ),
        titleTextStyle: TextStyle(
          fontSize: 28.sp,
          letterSpacing: 0.36,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? true : false,
        child: Padding(
          padding: EdgeInsets.only(
              left: 12.0,
              right: 12,
              bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 0 : 12.0),
          child: Column(
            children: [
              Obx(
                () => Expanded(
                  child: _blacklistWhitelistController.whiteListSites.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'This list is empty',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Add a link to the site you want to restrict from checks',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        )
                      : ElementsListView(
                          blacklistWhitelistController:
                              _blacklistWhitelistController,
                          list: _blacklistWhitelistController.whiteListSites,
                          listName: 'whiteListSites',
                        ),
                ),
              ),
              Container(
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
                ),
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Add link',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.36,
                    ),
                  ),
                  onPressed: () async {
                    if (!_paywallController.isSubscriptionActive.value!) {
                      Get.to(
                          () => PaywallScreen(
                              products: _paywallController.products!),
                          fullscreenDialog: true);
                      return;
                    }
                    String? urlLink;
                    urlLink = await showCupertinoDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return Theme(
                          data: ThemeData.dark(),
                          child: CupertinoAlertDialog(
                            title: const Text('Add link'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                    'Paste the link to the site you want to whitelist'),
                                const SizedBox(height: 10),
                                CupertinoTextField(
                                  controller: _textEditingController,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                  decoration: BoxDecoration(
                                    color: const CupertinoDynamicColor
                                        .withBrightness(
                                      color: CupertinoColors.white,
                                      darkColor:
                                          CupertinoColors.darkBackgroundGray,
                                    ),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  autofocus: true,
                                  autocorrect: false,
                                  placeholder: 'Paste URL',
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                onPressed: () => Get.back(),
                                isDefaultAction: false,
                                child: const Text('Cancel'),
                              ),
                              CupertinoDialogAction(
                                onPressed: () => Get.back(
                                    result: _textEditingController.text),
                                isDefaultAction: true,
                                child: const Text('Add'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    _textEditingController.clear();
                    if (urlLink != null) {
                      _blacklistWhitelistController
                          .addToWhiteListSites(urlLink);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
