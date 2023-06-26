import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class BlurWrapper extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color blurColor;
  final BorderRadius? borderRadius;
  final Widget? overlay;

  const BlurWrapper(
      {super.key,
      required this.child,
      required this.blur,
      required this.blurColor,
      this.borderRadius,
      this.overlay});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.getUser();
    bool isPremium = false;
    if (user != null) {
      isPremium = user.isPremium;
    }
    return isPremium
        ? Container(
            child: child,
          )
        : Blur(
            blur: blur,
            blurColor: blurColor,
            borderRadius: borderRadius,
            overlay: overlay,
            child: child,
          );
  }
}