import 'package:flutter/material.dart';

import '../consts/constants.dart';

class HowToScreen extends StatelessWidget {
  const HowToScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Constants.kBackgroundColorGray,
        elevation: 0,
        title: const Text(
          'How to start',
        ),
        titleTextStyle: const TextStyle(
          fontSize: 28,
          letterSpacing: 0.36,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 3.2,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Constants.kMainElementsGrayColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Turn on for Safari:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/settings.png',
                    height: 28,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Open ',
                      style: TextStyle(
                        fontSize: 17,
                        color: Constants.kLightGrayTextColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Settings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/safari.png',
                    height: 28,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Go to ',
                      style: TextStyle(
                        fontSize: 17,
                        color: Constants.kLightGrayTextColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Safari > Extensions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/switch.png',
                    height: 23.77,
                    width: 28,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Allow all ',
                      style: TextStyle(
                        fontSize: 17,
                        color: Constants.kLightGrayTextColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Stop Fraud ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: """content \nblocking rules to apply""",
                          style: TextStyle(
                            color: Constants.kLightGrayTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
