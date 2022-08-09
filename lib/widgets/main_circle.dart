import 'package:flutter/material.dart';

import '../consts/constants.dart';

class MainCircle extends StatelessWidget {
  const MainCircle({
    super.key,
    required AnimationController animationController,
    required bool isTrackingEnabled,
    required bool isTryingToFetchExtensionStatus,
    required bool isExtensionEnabled,
    required bool isInternetConnected,
    required bool dataAvailable,
    required Animation animation,
  })  : _animationController = animationController,
        _isTrackingEnabled = isTrackingEnabled,
        _isTryingToFetchExtensionStatus = isTryingToFetchExtensionStatus,
        _isExtensionEnabled = isExtensionEnabled,
        _isInternetConnected = isInternetConnected,
        _dataAvailable = dataAvailable,
        _animation = animation;

  final AnimationController _animationController;
  final bool _isTrackingEnabled;
  final bool _isTryingToFetchExtensionStatus;
  final bool _isExtensionEnabled;
  final bool _isInternetConnected;
  final bool _dataAvailable;
  final Animation _animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Center(
          child: _isTrackingEnabled
              ? _isTryingToFetchExtensionStatus
                  ? const Text(
                      'Fetching extension status...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.36,
                        color: Colors.white,
                      ),
                    )
                  : !_isExtensionEnabled
                      ? const Text(
                          'Extension is disabled',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.36,
                            color: Colors.white,
                          ),
                        )
                      : !_isInternetConnected
                          ? const Text(
                              'No internet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.36,
                                color: Colors.white,
                              ),
                            )
                          : !_dataAvailable
                              ? const Text(
                                  'Fetching data...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.36,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Tap to stop',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.36,
                                    color: Colors.white,
                                  ),
                                )
              : const Text(
                  'Tap to start',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.36,
                    color: Colors.white,
                  ),
                )),
      builder: (BuildContext context, Widget? child) {
        return AnimatedContainer(
          width: MediaQuery.of(context).size.width / 1.7,
          height: MediaQuery.of(context).size.width / 1.7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: _isTrackingEnabled
                    ? !_isTryingToFetchExtensionStatus
                        ? _dataAvailable
                            ? Constants.kGreenPrimaryColor
                            : _isExtensionEnabled
                                ? Colors.yellow
                                : Colors.red
                        : Colors.orange
                    : const Color(0x33000000),
                width: 4,
                strokeAlign: StrokeAlign.center),
            gradient: const RadialGradient(
              radius: 0.49,
              colors: [
                Color.fromARGB(255, 100, 100, 100),
                Constants.kBackgroundColorGray
              ],
            ),
            boxShadow: [
              BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: !_isTryingToFetchExtensionStatus
                      ? _dataAvailable
                          ? Constants.kGreenPrimaryColor
                          : _isExtensionEnabled
                              ? Colors.yellow
                              : Colors.red
                      : Colors.orange,
                  blurRadius: _animation.value,
                  spreadRadius: 0.0),
            ],
          ),
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },
    );
  }
}
