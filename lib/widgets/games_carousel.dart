import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_scratch/widgets/game_card_big.dart';
import 'package:simple_scratch/widgets/game_card_carousel.dart';
import 'package:transparent_image/transparent_image.dart';
import '../constants.dart';
import '../models/ticket.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class GamesCarousel extends StatefulWidget {
  final List<Ticket> bestTickets;
  const GamesCarousel({Key? key, required this.bestTickets}) : super(key: key);

  @override
  State<GamesCarousel> createState() => _GamesCarouselState();
}

class _GamesCarouselState extends State<GamesCarousel> {
  List<Widget> gameSliders = [];
  late bool isPremium = false;
  bool isLoading = false;

  @override
  void initState() {
    gameSliders = widget.bestTickets
        .map((ticket) => GameCardBig(ticket: ticket))
        .toList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.bestTickets.forEach((ticket) {
        precacheImage(NetworkImage(ticket.img), context);
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserIsPremium(auth.FirebaseAuth.instance.currentUser);
    });
    print(
        'Current firebase user is ${auth.FirebaseAuth.instance.currentUser?.email}');
    super.initState();
  }

  getUserIsPremium(auth.User? user) async {
    setState(() {
      isLoading = true;
    });
    if (user != null) {
      //await user.getIdToken(true);
      final idTokenResult = await user.getIdTokenResult();
      isPremium = idTokenResult.claims?['stripeRole'] != null ? true : false;
      // setState(() {});
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    //bool isPremium = user?.isPremium == null ? false : true;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: kGreenLightColor,
            ),
          )
        : isPremium
            ? CarouselSlider(
                items: widget.bestTickets
                    .map((ticket) => GameCardCarousel(ticket: ticket))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 1.25,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                ),
              )
            : Stack(
                children: [
                  CarouselSlider(
                    items: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                            child: GameCardCarousel(
                                ticket: widget.bestTickets.first)),
                      )
                    ],
                    options: CarouselOptions(
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      autoPlay: false,
                      aspectRatio: 1.25,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: kBlackLightColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Premium Content\n',
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              text: 'Upgrade Today!',
                              style: TextStyle(
                                  fontSize: 25,
                                  decoration: TextDecoration.underline,
                                  color: kBlackLightColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
    // Center(
    //         child: Stack(
    //           children: [
    //             ClipRRect(
    //               borderRadius: const BorderRadius.all(
    //                 Radius.circular(8),
    //               ),
    //               child: ImageFiltered(
    //                 imageFilter: ImageFilter.blur(
    //                     sigmaX: 60, sigmaY: 60, tileMode: TileMode.clamp),
    //                 child: FadeInImage.memoryNetwork(
    //                     height: 320,
    //                     width: 320,
    //                     placeholder: kTransparentImage,
    //                     image:
    //                         'https://nclottery.com/Content/Images/Instant/nc842_sqr.png'),
    //               ),
    //             ),
    //             Positioned.fill(
    //               child: Align(
    //                 alignment: Alignment.center,
    //                 child: RichText(
    //                     text: TextSpan(
    //                         recognizer: TapGestureRecognizer()..onTap = () {},
    //                         text: 'Premium',
    //                         style: TextStyle(
    //                             fontSize: 30,
    //                             fontWeight: FontWeight.bold,
    //                             decoration: TextDecoration.underline,
    //                             color: kGreenLightColor))),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
  }
}