library introduction_screen;

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/src/helper.dart';
import 'package:introduction_screen/src/model/page_view_model.dart';
import 'package:introduction_screen/src/model/position.dart';
import 'package:introduction_screen/src/ui/intro_button.dart';
import 'package:introduction_screen/src/ui/intro_page.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';
import 'package:stop_fraud/screens/main_screen.dart';
import 'package:stop_fraud/screens/paywall_screen.dart';

import '../consts/constants.dart';

class CustomIntroWidget extends StatefulWidget {
  /// All pages of the onboarding
  final List<PageViewModel>? pages;

  /// All pages of the onboarding, as a complete widget instead of a PageViewModel
  final List<Widget>? rawPages;

  /// Callback when Done button is pressed
  final VoidCallback? onDone;

  /// Callback when Skip button is pressed
  final VoidCallback? onSkip;

  /// Callback when page change
  final ValueChanged<int>? onChange;

  /// Done button child for the pre-made TextButton
  final Widget? done;

  /// Override pre-made done button.
  /// You can what you want (button, text, image, ...)
  final Widget? overrideDone;

  /// Skip button child for the pre-made TextButton
  final Widget? skip;

  /// Override pre-made skip button.
  /// You can what you want (button, text, image, ...)
  final Widget? overrideSkip;

  /// Next button child for the pre-made TextButton
  final Widget? next;

  /// Override pre-made next button.
  /// You can what you want (button, text, image, ...)
  final Widget? overrideNext;

  /// Back button child for the pre-made TextButton
  final Widget? back;

  /// Override pre-made back button.
  /// You can what you want (button, text, image, ...)
  final Widget? overrideBack;

  /// Is the Skip button should be display
  ///
  /// @Default `false`
  final bool showSkipButton;

  /// Is the Next button should be display
  ///
  /// @Default `true`
  final bool showNextButton;

  /// If the 'Done' button should be rendered at all the end
  ///
  /// @Default `true`
  final bool showDoneButton;

  /// Is the Back button should be display
  ///
  /// @Default `false`
  final bool showBackButton;

  /// Is the progress indicator should be display
  ///
  /// @Default `true`
  final bool isProgress;

  /// Enable or not onTap feature on progress indicator
  ///
  /// @Default `true`
  final bool isProgressTap;

  /// Is the user is allow to change page
  ///
  /// @Default `false`
  final bool freeze;

  /// Global background color (only visible when a page has a transparent background color)
  final Color? globalBackgroundColor;

  /// Dots decorator to custom dots color, size and spacing
  final DotsDecorator dotsDecorator;

  /// Decorator to customize the appearance of the progress dots container.
  /// This is useful when the background image is full screen.
  final Decoration? dotsContainerDecorator;

  /// Animation duration in millisecondes
  ///
  /// @Default `350`
  final int animationDuration;

  /// Index of the initial page
  ///
  /// @Default `0`
  final int initialPage;

  /// Flex ratio of the skip or back button
  ///
  /// @Default `1`
  final int skipOrBackFlex;

  /// Flex ratio of the progress indicator
  ///
  /// @Default `1`
  final int dotsFlex;

  /// Flex ratio of the next/done button
  ///
  /// @Default `1`
  final int nextFlex;

  /// Type of animation between pages
  ///
  /// @Default `Curves.easeIn`
  final Curve curve;

  /// Base style for all buttons
  final ButtonStyle? baseBtnStyle;

  /// Done button style
  final ButtonStyle? doneStyle;

  /// Skip button style
  final ButtonStyle? skipStyle;

  /// Next button style
  final ButtonStyle? nextStyle;

  /// Back button style
  final ButtonStyle? backStyle;

  /// Done button semantic label
  final String? doneSemantic;

  /// Skip button semantic label
  final String? skipSemantic;

  /// Next button semantic label
  final String? nextSemantic;

  /// Back button semantic label
  final String? backSemantic;

  /// Enable or disabled top SafeArea
  ///
  /// @Default `false`
  final bool isTopSafeArea;

  /// Enable or disabled bottom SafeArea
  ///
  /// @Default `false`
  final bool isBottomSafeArea;

  /// Controls position
  ///
  /// @Default `Position(left: 0, right: 0, bottom: 0)`
  final Position controlsPosition;

  /// Margin for controls
  ///
  /// @Default `EdgeInsets.zero`
  final EdgeInsets controlsMargin;

  /// Padding for controls
  ///
  /// @Default `EdgeInsets.all(16.0)`
  final EdgeInsets controlsPadding;

  /// A header widget to be shown on every screen
  final Widget? globalHeader;

  /// A footer widget to be shown on every screen
  final bool? showGlobalFooter;

  /// ScrollController of vertical SingleChildScrollView for every single page
  final List<ScrollController?>? scrollControllers;

  /// Scroll/Axis direction of pages, can he horizontal or vertical
  ///
  /// @Default `Axis.horizontal`
  final Axis pagesAxis;

  /// PageView scroll physics (only when freeze is set to false)
  ///
  /// @Default `BouncingScrollPhysics()`
  final ScrollPhysics scrollPhysics;

  /// Is right to left behaviour
  ///
  /// @Default `false`
  final bool rtl;

  const CustomIntroWidget({
    Key? key,
    this.pages,
    this.rawPages,
    this.onDone,
    this.onSkip,
    this.onChange,
    this.done,
    this.overrideDone,
    this.skip,
    this.overrideSkip,
    this.next,
    this.overrideNext,
    this.back,
    this.overrideBack,
    this.showSkipButton = false,
    this.showNextButton = true,
    this.showDoneButton = true,
    this.showBackButton = false,
    this.isProgress = true,
    this.isProgressTap = true,
    this.freeze = false,
    this.globalBackgroundColor,
    this.dotsDecorator = const DotsDecorator(),
    this.dotsContainerDecorator,
    this.animationDuration = 350,
    this.initialPage = 0,
    this.skipOrBackFlex = 1,
    this.dotsFlex = 1,
    this.nextFlex = 1,
    this.curve = Curves.easeIn,
    this.baseBtnStyle,
    this.skipStyle,
    this.nextStyle,
    this.doneStyle,
    this.backStyle,
    this.skipSemantic,
    this.nextSemantic,
    this.doneSemantic,
    this.backSemantic,
    this.isTopSafeArea = false,
    this.isBottomSafeArea = false,
    this.controlsPosition = const Position(left: 0, right: 0, bottom: 0),
    this.controlsMargin = EdgeInsets.zero,
    this.controlsPadding = const EdgeInsets.all(16.0),
    this.globalHeader,
    this.showGlobalFooter,
    this.scrollControllers,
    this.pagesAxis = Axis.horizontal,
    this.scrollPhysics = const BouncingScrollPhysics(),
    this.rtl = false,
  })  : assert(
          pages != null || rawPages != null,
          "You must set either 'pages' or 'rawPages' parameter",
        ),
        assert(
          (pages?.length ?? rawPages?.length ?? 0) > 0,
          "You must provide at least one page using 'pages' or 'rawPages' parameter !",
        ),
        assert(
          !showDoneButton || done != null || overrideDone != null,
          "You must set 'done' or 'overrideDone' parameter, or set 'showDoneButton' to false",
        ),
        assert(
          done == null || onDone != null,
          "If you set 'done' parameter, you must also set 'onDone' parameter",
        ),
        assert(
          !showSkipButton || skip != null || overrideSkip != null,
          "You must set 'skip' or 'overrideSkip' parameter, or set 'showSkipButton' to false",
        ),
        assert(
          !showNextButton || next != null || overrideNext != null,
          "You must set 'next' or 'overrideNext' parameter, or set 'showNextButton' to false",
        ),
        assert(
          !showBackButton || back != null || overrideBack != null,
          "You must set 'back' or 'overrideBack' parameter, or set 'showBackButton' to false",
        ),
        assert(
          !(showBackButton && showSkipButton),
          "You cannot set 'showBackButton' and 'showSkipButton' to true. Only one, or both false.",
        ),
        assert(
          skipOrBackFlex >= 0 && dotsFlex >= 0 && nextFlex >= 0,
          'Flex parameters must be >= 0',
        ),
        assert(
          initialPage >= 0,
          'Initial page parameter must by a positive number, >= 0.',
        ),
        super(key: key);

  @override
  CustomIntroWidgetState createState() => CustomIntroWidgetState();
}

class CustomIntroWidgetState extends State<CustomIntroWidget> {
  late PageController _pageController;
  double _currentPage = 0.0;
  bool _isSkipPressed = false;
  bool _isScrolling = false;

  PageController get controller => _pageController;

  @override
  void initState() {
    super.initState();
    int initialPage = min(widget.initialPage, getPagesLength() - 1);
    _currentPage = initialPage.toDouble();
    _pageController = PageController(initialPage: initialPage);
  }

  int getPagesLength() {
    return (widget.pages ?? widget.rawPages!).length;
  }

  void next() => !_isScrolling ? animateScroll(_currentPage.round() + 1) : null;

  void previous() => animateScroll(_currentPage.round() - 1);

  Future<void> _onSkip() async {
    if (widget.onSkip != null) {
      widget.onSkip!();
    } else {
      await skipToEnd();
    }
  }

  Future<void> skipToEnd() async {
    setState(() => _isSkipPressed = true);
    await animateScroll(getPagesLength() - 1);
    if (mounted) {
      setState(() => _isSkipPressed = false);
    }
  }

  Future<void> animateScroll(int page) async {
    setState(() => _isScrolling = true);
    await _pageController.animateToPage(
      max(min(page, getPagesLength() - 1), 0),
      duration: Duration(milliseconds: widget.animationDuration),
      curve: widget.curve,
    );
    if (mounted) {
      setState(() => _isScrolling = false);
    }
  }

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics && metrics.page != null) {
      if (mounted) {
        setState(() => _currentPage = metrics.page!);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = (_currentPage.round() == getPagesLength() - 1);
    Widget? topLeftBtn;
    Widget? topRightBtn;

    if (!_isSkipPressed && !isLastPage) {
      topRightBtn = IntroButton(
        style: widget.baseBtnStyle?.merge(widget.skipStyle) ?? widget.skipStyle,
        semanticLabel: widget.skipSemantic,
        onPressed: _onSkip,
        child: widget.skip!,
      );
    }
    if (widget.showBackButton && _currentPage.round() > 0) {
      topLeftBtn = widget.overrideBack ??
          IntroButton(
            style: widget.baseBtnStyle?.merge(widget.backStyle) ??
                widget.backStyle,
            semanticLabel: widget.backSemantic,
            onPressed: !_isScrolling ? previous : null,
            child: widget.back!,
          );
    }

    return Scaffold(
      backgroundColor: widget.globalBackgroundColor,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned.fill(
            child: NotificationListener<ScrollNotification>(
              onNotification: _onScroll,
              child: PageView(
                reverse: widget.rtl,
                scrollDirection: widget.pagesAxis,
                controller: _pageController,
                onPageChanged: widget.onChange,
                physics: widget.freeze
                    ? const NeverScrollableScrollPhysics()
                    : widget.scrollPhysics,
                children: widget.pages
                        ?.mapIndexed(
                          (index, page) => IntroPage(
                            page: page,
                            scrollController: widget.scrollControllers
                                ?.elementAtOrNull(index),
                            isTopSafeArea: widget.isTopSafeArea,
                            isBottomSafeArea: widget.isBottomSafeArea,
                          ),
                        )
                        .toList() ??
                    widget.rawPages!,
              ),
            ),
          ),
          if (widget.globalHeader != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: widget.globalHeader!,
            ),
          Positioned(
            left: 0,
            top: IphoneHasNotch.hasNotch ? 40 : 10,
            child: topLeftBtn ?? const SizedBox(),
          ),
          Positioned(
            right: 0,
            top: IphoneHasNotch.hasNotch ? 40 : 10,
            child: IntroButton(
              style: widget.baseBtnStyle?.merge(widget.skipStyle) ??
                  widget.skipStyle,
              semanticLabel: widget.skipSemantic,
              onPressed: _onSkip,
              child: topRightBtn ?? const SizedBox(),
            ),
          ),
          Positioned(
            left: widget.controlsPosition.left,
            top: widget.controlsPosition.top,
            right: widget.controlsPosition.right,
            bottom: widget.controlsPosition.bottom,
            child: Container(
              padding: widget.controlsPadding,
              margin: widget.controlsMargin,
              decoration: widget.dotsContainerDecorator,
              child: Row(
                children: [
                  Expanded(
                    flex: widget.dotsFlex,
                    child: Center(
                      child: widget.isProgress
                          ? Semantics(
                              label:
                                  "Page ${_currentPage.round() + 1} of ${getPagesLength()}",
                              excludeSemantics: true,
                              child: DotsIndicator(
                                reversed: widget.rtl,
                                dotsCount: getPagesLength(),
                                position: _currentPage,
                                decorator: widget.dotsDecorator,
                                onTap: widget.isProgressTap && !widget.freeze
                                    ? (pos) => animateScroll(pos.toInt())
                                    : null,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ].asReversed(widget.rtl),
              ),
            ),
          ),
          if (widget.showGlobalFooter != null)
            Positioned(
              bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 30 : 10,
              child: Container(
                constraints: const BoxConstraints(minHeight: 67),
                width: MediaQuery.of(context).size.width / 1.1,
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
                  shadows: const [
                    BoxShadow(
                      offset: Offset(0, 9),
                      blurRadius: 32,
                      spreadRadius: 0,
                      color: Constants.kGreenShadowColor,
                    )
                  ],
                ),
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: !isLastPage
                      ? const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.36,
                          ),
                        )
                      : const Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.36,
                          ),
                        ),
                  onPressed: () {
                    if (!isLastPage) {
                      next();
                    } else {
                      GetStorage().write('isIntroCompleted', true);
                      Get.off(
                        () => const MainScreen(),
                        fullscreenDialog: false,
                      );
                    }
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}