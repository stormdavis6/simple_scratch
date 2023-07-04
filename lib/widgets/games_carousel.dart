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
  final List<Ticket> allTickets;
  final bool isPremium;
  const GamesCarousel(
      {Key? key,
      required this.bestTickets,
      required this.allTickets,
      required this.isPremium})
      : super(key: key);

  @override
  State<GamesCarousel> createState() => _GamesCarouselState();
}

class _GamesCarouselState extends State<GamesCarousel> {
  List<Widget> gameSliders = [];
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    //bool isPremium = user?.isPremium == null ? false : true;
    return widget.isPremium
        ? CarouselSlider(
            items: widget.bestTickets
                .map((ticket) => GameCardCarousel(
                      bestTicket: ticket,
                      dashboardTicket: widget.allTickets
                          .firstWhere((element) => element.name == ticket.name),
                      isPremium: widget.isPremium,
                    ))
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
                        imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                        child: GameCardCarousel(
                          bestTicket: widget.bestTickets.first,
                          dashboardTicket: widget.allTickets.firstWhere(
                              (element) =>
                                  element.name ==
                                  widget.bestTickets.first.name),
                          isPremium: widget.isPremium,
                        )),
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