import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_scratch/constants.dart';
import 'package:simple_scratch/widgets/premium_sheet.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/ticket.dart';
import '../screens/game_details_screen.dart';
import '../screens/premium_screen.dart';

class GameCardCarouselBlurred extends StatefulWidget {
  const GameCardCarouselBlurred({
    Key? key,
  }) : super(key: key);

  @override
  State<GameCardCarouselBlurred> createState() =>
      _GameCardCarouselBlurredState();
}

class _GameCardCarouselBlurredState extends State<GameCardCarouselBlurred> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PremiumScreen();
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 3.0,
        ),
        child: Material(
          elevation: 3,
          color: kBackgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: Image.asset(
                  'assets/images/blurred_ticket_sqr.png',
                  height: 400,
                  width: 400,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}