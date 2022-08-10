import 'package:apphud/apphud.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stop_fraud/models/click_model.dart';
import 'package:http/http.dart' as http;

class ValidationController extends GetxController {
  RxnInt tempClickId = RxnInt();
  http.Response? response;
  Future<ClickModel?> validateClick() async {
    //test click id
    tempClickId.value = 123456;
    //place this click_id to clipboard
    await Clipboard.setData(
      ClipboardData(
        text: tempClickId.toString(),
      ),
    );
    //get data from clipboard
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);

    try {
      response = await http.get(
        Uri.parse('https://check.stopscamapp.com/validation?cid=${data!.text}'),
      );
    } catch (e) {
      return null;
    }
    final clickModel = clickModelFromMap(response!.body);

    return clickModel;
  }

  Future sendDataToTrackerServer() async {
    String userID = await Apphud.userID();

    try {
      response = await http.get(
        Uri.parse(
            'https://api.stopscamapp.com/post/install?cid=$tempClickId&ud=$userID'),
      );
    } catch (e) {
      return null;
    }
  }

  Future sendInfoAboutSubscription() async {
    try {
      response = await http.get(
        Uri.parse('https://api.stopscamapp.com/post/subs?cid=$tempClickId'),
      );
    } catch (e) {
      return null;
    }
  }
}
