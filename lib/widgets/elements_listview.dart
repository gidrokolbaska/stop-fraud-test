import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../consts/constants.dart';
import '../controllers/whitelist_blacklist_controller.dart';
import 'list_element_widget.dart';

class ElementsListView extends StatelessWidget {
  const ElementsListView({
    Key? key,
    required BlacklistWhitelistController blacklistWhitelistController,
    required this.list,
    required this.listName,
  })  : _blacklistWhitelistController = blacklistWhitelistController,
        super(key: key);

  final BlacklistWhitelistController _blacklistWhitelistController;
  final RxList<dynamic> list;
  final String listName;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(
              milliseconds: 300,
            ),
            child: SlideAnimation(
              child: ScaleAnimation(
                child: ListElementWidget(
                  title: list[index],
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(44, 44),
                      maximumSize: const Size(44, 44),
                      padding: EdgeInsets.zero,
                      backgroundColor: Constants.kBackgroundColorDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      int? testindex;
                      testindex = await showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return Theme(
                            data: ThemeData.dark(),
                            child: CupertinoAlertDialog(
                              title: const Text('Delete link'),
                              content: const Text(
                                  'Are you sure you want to remove this link from Black list?'),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: () => Get.back(),
                                  isDefaultAction: false,
                                  child: const Text('Cancel'),
                                ),
                                CupertinoDialogAction(
                                  onPressed: () => Get.back(result: index),
                                  isDefaultAction: true,
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      if (testindex != null) {
                        list.removeAt(testindex);
                        _blacklistWhitelistController.removeLinkFromSitesList(
                            list: list, listName: listName);
                      }
                    },
                    child: const Center(
                      child: Icon(
                        Icons.close_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10.0,
          );
        },
      ),
    );
  }
}
