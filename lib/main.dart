import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stop_fraud/consts/constants.dart';
import 'package:stop_fraud/controllers/paywall_controller.dart';
import 'package:stop_fraud/screens/main_screen.dart';
import 'screens/my_introduction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initPlatformState();
  await GetStorage.init();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final PaywallController _paywallController = Get.put(
    PaywallController(),
  );
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.blue,
            fontFamily: 'Lato',
            scaffoldBackgroundColor: Constants.kBackgroundColorGray,
          ),
          home: _paywallController.isIntroCompleted.value != null &&
                  _paywallController.isIntroCompleted.value!
              ? const MainScreen()
              : const CustomIntroductionScreen(),
        );
      },
    );
  }
}

Future<void> initPlatformState() async {
  //initialize AppHud
  await Apphud.start(
    apiKey: "app_aLaTvpg6i7y9UZY991MJBS3u7sPyT2",
    observerMode: true,
  );
}
