import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/whitelist_blacklist_controller.dart';
import '../screens/blacklist_screen.dart';
import '../screens/whitelist_screen.dart';
import 'links_card.dart';

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required BlacklistWhitelistController blacklistWhitelistController,
  }) : _blacklistWhitelistController = blacklistWhitelistController;

  final BlacklistWhitelistController _blacklistWhitelistController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(
          () => LinksCard(
            linksAmount: _blacklistWhitelistController.blackListSites.length,
            cardName: 'Blacklist',
            onClick: () => Get.to(
              () => const BlacklistScreen(),
            ),
          ),
        ),
        Obx(
          () => LinksCard(
            linksAmount: _blacklistWhitelistController.whiteListSites.length,
            cardName: 'Whitelist',
            onClick: () => Get.to(
              () => const WhitelistScreen(),
            ),
          ),
        ),
      ],
    );
  }
}
