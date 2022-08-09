import 'package:flutter/material.dart';

import '../consts/constants.dart';

class ListElementWidget extends StatelessWidget {
  const ListElementWidget({
    Key? key,
    required this.title,
    required this.trailing,
    this.onTap,
  }) : super(key: key);
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
      child: Material(
        color: Constants.kMainElementsGrayColor,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 17.0,
              color: Colors.white,
            ),
          ),
          trailing: trailing,
          //tileColor: Constants.kMainElementsGrayColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          onTap: onTap,
          contentPadding: const EdgeInsets.only(
            left: 16.0,
            right: 8,
          ),
        ),
      ),
    );
  }
}
