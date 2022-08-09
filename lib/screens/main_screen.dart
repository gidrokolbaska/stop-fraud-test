import 'dart:async';

import 'package:async/async.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:stop_fraud/consts/constants.dart';
import 'package:stop_fraud/controllers/paywall_controller.dart';
import 'package:stop_fraud/controllers/whitelist_blacklist_controller.dart';
import 'package:stop_fraud/screens/blacklist_screen.dart';
import 'package:stop_fraud/screens/howto_screen.dart';
import 'package:stop_fraud/screens/paywall_screen.dart';

import 'package:stop_fraud/screens/settings_screen.dart';
import 'package:stop_fraud/screens/whitelist_screen.dart';
import 'package:stop_fraud/widgets/links_card.dart';

import '../widgets/cards.dart';
import '../widgets/main_circle.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final PaywallController _paywallController = Get.find();
  late AnimationController _animationController;
  late Animation _animation;
  CancelableOperation? _myCancelableFuture;
  bool _isTrackingEnabled = false;
  bool _isTryingToFetchExtensionStatus = false;
  bool _isExtensionEnabled = false;
  bool _dataAvailable = false;
  bool _isInternetConnected = false;
  late StreamSubscription<ConnectivityResult> subscription;
  late Timer _timer;
  late Timer _timer2;
  final BlacklistWhitelistController _blacklistWhitelistController =
      Get.put(BlacklistWhitelistController());
  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.none) {
        setState(() {
          _isInternetConnected = false;
        });
      } else {
        setState(() {
          _isInternetConnected = true;
        });
      }
    });
    _paywallController.fetchStatusOfCurrentSubscription(context);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween(begin: 0.0, end: 25.0).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    subscription.cancel();
  }

  Future _myFuture() async {
    //hardcoded timer in here to actually see all the animation transitions properly
    _timer = Timer(
      const Duration(seconds: 2),
      () async {
        _isExtensionEnabled =
            await _blacklistWhitelistController.checkIfExtensionIsEnabled();

        setState(() {
          _isTryingToFetchExtensionStatus = false;
        });
        if (_isExtensionEnabled) {
          var connectivityResult = await (Connectivity().checkConnectivity());

          if (connectivityResult == ConnectivityResult.none) {
            setState(() {
              _isInternetConnected = false;
            });
          } else if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            setState(() {
              _isInternetConnected = true;
            });
          }

          _timer2 = Timer(const Duration(seconds: 2), () async {
            _dataAvailable =
                await _blacklistWhitelistController.fetchLinksFromApi();
            setState(() {});
          });
        }
      },
    );
  }

  Future _clickLoadStuff() async {
    if (!_paywallController.isSubscriptionActive.value!) {
      Get.to(() => PaywallScreen(products: _paywallController.products!),
          fullscreenDialog: true);
      return;
    }
    if (_isTrackingEnabled) {
      _animationController.duration = const Duration(milliseconds: 200);
      _animationController.reverse();
    } else {
      _animationController.duration = const Duration(seconds: 2);
      _animationController.repeat(reverse: true);
    }

    setState(
      () {
        _isTrackingEnabled = !_isTrackingEnabled;
        _dataAvailable = false;
        _isExtensionEnabled = false;
        _isTryingToFetchExtensionStatus = true;
      },
    );

    if (_isTrackingEnabled) {
      _myCancelableFuture = CancelableOperation.fromFuture(
        _myFuture(),
        onCancel: () {
          setState(() {
            _dataAvailable = false;
            _isTryingToFetchExtensionStatus = false;
            _isExtensionEnabled = false;
            _isTrackingEnabled = false;
          });
        },
      );
      _myCancelableFuture?.value;
    } else {
      _timer.cancel();
      _timer2.cancel();
      _myCancelableFuture?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kBackgroundColorGray,
        elevation: 0,
        title: const Text(
          'StopFraud',
        ),
        titleTextStyle: const TextStyle(
          fontSize: 28,
          letterSpacing: 0.36,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            splashRadius: 1,
            icon: const Icon(
              Icons.settings,
              size: 28.0,
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(
                () => SettingsScreen(),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                await _clickLoadStuff();
              },
              child: MainCircle(
                  animationController: _animationController,
                  isTrackingEnabled: _isTrackingEnabled,
                  isTryingToFetchExtensionStatus:
                      _isTryingToFetchExtensionStatus,
                  isExtensionEnabled: _isExtensionEnabled,
                  isInternetConnected: _isInternetConnected,
                  dataAvailable: _dataAvailable,
                  animation: _animation),
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  () => const HowToScreen(),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.transparent,
              ),
              child: Text(
                'How to start?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.36,
                ),
              ),
            ),
            Cards(blacklistWhitelistController: _blacklistWhitelistController),
          ],
        ),
      ),
    );
  }
}
