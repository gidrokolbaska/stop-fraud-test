import 'dart:io';
import 'package:app_group_directory/app_group_directory.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stop_fraud/models/blacklist.dart';
import 'package:stop_fraud/models/whitelist.dart';

class BlacklistWhitelistController extends GetxController {
  var blackListSites = [].obs;
  var whiteListSites = [].obs;
  List<String> blackListFinalJson = [];
  List<String> whiteListFinalJson = [];
  late GetStorage listsStorage;

  static const extensionChannel =
      MethodChannel('com.gidrokolbaska.stopFraud/extension');
  @override
  void onInit() {
    super.onInit();
    //fetch current blacklist and whitelist values from GetStorage
    listsStorage = GetStorage();
    blackListSites.value = listsStorage.read('blacklistSites') ?? [];
    whiteListSites.value = listsStorage.read('whiteListSites') ?? [];
  }

  void addToBlackListSites(String link) async {
    blackListSites.add(
      link,
    );

    await GetStorage().write(
      'blacklistSites',
      blackListSites,
    );
  }

  void removeLinkFromSitesList(
      {required RxList<dynamic> list, required String listName}) async {
    listsStorage.remove(listName);
    await GetStorage().write(
      listName,
      list,
    );
  }

  void addToWhiteListSites(String link) async {
    whiteListSites.add(
      link,
    );

    await GetStorage().write(
      'whiteListSites',
      whiteListSites,
    );
  }

  Future<bool> checkIfExtensionIsEnabled() async {
    bool result;
    result = await extensionChannel.invokeMethod('getExtensionStatus');

    return result;
  }

  Future<bool> fetchLinksFromApi() async {
    var response;
    try {
      response = await http.get(
        Uri.parse('https://block.stopscamapp.com/adplexity.txt'),
      );
    } catch (e) {
      return false;
    }

    var fetchedLinks = response.body.toString().split('\n');

//clear all lists
    blackListFinalJson.clear();
    whiteListFinalJson.clear();
//convert fetched links to json and add it to the resulting list
    fetchedLinks
        .map(
          (site) => BlacklistModel(
            action: ModelActionBlackList(type: 'block'),
            trigger: TriggerBlackList(urlFilter: "https?:\/\/(www.)?$site.*"),
          ),
        )
        .toList()
        .forEach(
      (element) {
        blackListFinalJson.add(
          element.toJson(),
        );
      },
    );

    //convert user-defined links to json and add it to the resulting list
    blackListSites
        .map(
          (site) => BlacklistModel(
            action: ModelActionBlackList(type: 'block'),
            trigger: TriggerBlackList(urlFilter: "https?:\/\/(www.)?$site.*"),
          ),
        )
        .toList()
        .forEach(
      (element2) {
        blackListFinalJson.add(
          element2.toJson(),
        );
      },
    );

    //convert user-defined links from whitelist and add it to the resulting list
    whiteListSites
        .map(
          (element) => WhitelistModel(
            action: ModelActionWhiteList(type: "ignore-previous-rules"),
            trigger: TriggerWhiteList(urlFilter: ".*", ifDomain: ["*$element"]),
          ),
        )
        .toList()
        .forEach(
      (element2) {
        whiteListFinalJson.add(element2.toJson());
      },
    );

//add all the rules to the resulting list of strings
    blackListFinalJson.addAll(whiteListFinalJson);

//get the path of the App Group
    Directory? sharedDirectory = await AppGroupDirectory.getAppGroupDirectory(
        'group.com.gidrokolbaska.blockergroup');

//write the contents to finalList.json
    await File('${sharedDirectory!.path}/finalList.json').writeAsString(
      blackListFinalJson.toString(),
    );

//reload Content Blocker
    await extensionChannel.invokeMethod('testreloadExtension');
    return true;
  }
}
