import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_scratch/constants.dart';

import '../services/auth_service.dart';

class BlurWrapper extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  const BlurWrapper({super.key, required this.child, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.getUser();
    bool isSignedIn = false;
    bool isPremium = false;
    if (user != null) {
      isSignedIn = true;
      isPremium = user.isPremium;
    }
    return isPremium
        ? Container(
            child: child,
          )
        : Blur(
            blur: 50,
            blurColor: kGreenLightColor,
            borderRadius: borderRadius,
            // BorderRadius.only(
            //   topLeft: Radius.circular(8),
            //   topRight: Radius.circular(8),
            //   bottomLeft: Radius.circular(8),
            //   bottomRight: Radius.circular(8),
            // ),
            child: child,
          );
  }
}