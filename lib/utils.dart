import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'constants.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static final String overallOdds =
      'Approximate odds of winning, including break-even prizes, established at the time of printing.';
  static showSnackBar(String? text, context) {
    if (text == null) return;

    // final snackBar = SnackBar(
    //   content: Text(
    //     text,
    //     textAlign: TextAlign.center,
    //   ),
    //   backgroundColor: kBlackLightColor,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(29.5),
    //   ),
    //   behavior: SnackBarBehavior.floating,
    //   margin: EdgeInsets.only(
    //       bottom: MediaQuery.of(context).size.height - 100,
    //       right: 20,
    //       left: 20),
    // );
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: text,
          backgroundColor: kGreenLightColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        dismissType: DismissType.onSwipe);
    // messengerKey.currentState!
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(snackBar);
  }

  static showInfoPopUp(Widget title, Widget body, context) {
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              backgroundColor: kBackgroundColor,
              elevation: 3,
              title: title,
              content: body,
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: kGreenLightColor,
                    foregroundColor: kGreenDarkColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: title,
              content: body,
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          });
    }
  }
}