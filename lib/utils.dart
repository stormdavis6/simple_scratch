import 'package:flutter/material.dart';

import 'constants.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      backgroundColor: kBlackLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(29.5),
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}