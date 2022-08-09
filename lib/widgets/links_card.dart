import 'package:flutter/material.dart';
import '../consts/constants.dart';

class LinksCard extends StatelessWidget {
  const LinksCard({
    Key? key,
    required this.linksAmount,
    required this.cardName,
    required this.onClick,
  }) : super(key: key);
  final int linksAmount;
  final String cardName;

  final VoidCallback? onClick;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width / 2.39,
      decoration: BoxDecoration(
        color: Constants.kMainElementsGrayColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 67,
                height: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Constants.kBackgroundColorDark,
                ),
                child: Center(
                  child: Text(
                    linksAmount.toString(),
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: Constants.kGreenPrimaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'links',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Text(
            cardName,
            style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w900,
                color: Colors.white),
          ),
          ElevatedButton(
            onPressed: onClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.kBackgroundColorDark,
              minimumSize: const Size(
                double.infinity,
                56,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}
