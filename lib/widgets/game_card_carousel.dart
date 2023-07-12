import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_scratch/constants.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/ticket.dart';
import '../screens/game_details_screen.dart';

class GameCardCarousel extends StatefulWidget {
  final Ticket bestTicket;
  final Ticket dashboardTicket;
  final bool isPremium;
  const GameCardCarousel(
      {Key? key,
      required this.bestTicket,
      required this.dashboardTicket,
      required this.isPremium})
      : super(key: key);

  @override
  State<GameCardCarousel> createState() => _GameCardCarouselState();
}

class _GameCardCarouselState extends State<GameCardCarousel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isPremium) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GameDetailsScreen(
              ticket: widget.dashboardTicket,
              isPremium: widget.isPremium,
            );
          }));
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Material(
              elevation: 3,
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.network(
                      widget.bestTicket.img,
                      fit: BoxFit.fill,
                      width: 400,
                      height: 400,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 400,
                            height: 400,
                            child: FadeInImage.memoryNetwork(
                              image: widget.bestTicket.img,
                              fit: BoxFit.fill,
                              width: 400,
                              height: 400,
                              placeholder: kTransparentImage,
                              imageErrorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                  Positioned(
                    width: widget.bestTicket.price.toString().length == 1
                        ? 29
                        : 41,
                    top: 0.0,
                    left: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBlackLightColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                      child: Text(
                        '\$${widget.bestTicket.price.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Material(
              elevation: 3,
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Container(
                width: 320,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Overall Odds: ',
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.bestTicket.overallOdds
                                      .substring(0, 2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                TextSpan(
                                  text: widget.bestTicket.overallOdds
                                      .substring(2, 4),
                                ),
                                TextSpan(
                                  text: widget.bestTicket.overallOdds
                                      .substring(4),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: kBlackLightColor,
                      height: 3,
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Calculated Odds: ',
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.bestTicket.calcOdds
                                      .substring(0, 2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                TextSpan(
                                  text: widget.bestTicket.calcOdds
                                      .substring(2, 4),
                                ),
                                TextSpan(
                                  text: widget.bestTicket.calcOdds.substring(4),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: kBlackLightColor,
                      height: 3,
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Calculated EV: ',
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '\$${widget.bestTicket.calculatedEv}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Column(
// children: [
// RichText(
// text: TextSpan(
// style: const TextStyle(
// fontFamily: 'Montserrat',
// fontSize: 16,
// color: Colors.black,
// ),
// children: <TextSpan>[
// TextSpan(
// text: 'Overall Odds: ',
// ),
// ],
// ),
// ),
// Divider(
// color: kBlackLightColor,
// height: 7,
// thickness: 1,
// ),
// RichText(
// text: TextSpan(
// style: const TextStyle(
// fontFamily: 'Montserrat',
// fontSize: 16,
// color: Colors.black,
// ),
// children: <TextSpan>[
// TextSpan(
// text: 'Calculated Odds: ',
// ),
// ],
// ),
// ),
// Divider(
// color: kBlackLightColor,
// height: 7,
// thickness: 1,
// ),
// RichText(
// text: TextSpan(
// style: const TextStyle(
// fontFamily: 'Montserrat',
// fontSize: 16,
// color: Colors.black,
// ),
// children: <TextSpan>[
// TextSpan(
// text: 'Calculated EV: ',
// ),
// ],
// ),
// ),
// ],
// ),
// Column(
// children: [
// RichText(
// text: TextSpan(
// style: const TextStyle(
// fontFamily: 'Montserrat',
// fontSize: 16,
// color: Colors.black,
// ),
// children: <TextSpan>[
// TextSpan(
// text: widget.bestTicket.overallOdds
//     .substring(0, 2),
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20),
// ),
// TextSpan(
// text: widget.bestTicket.overallOdds
//     .substring(2, 4),
// ),
// TextSpan(
// text: widget.bestTicket.overallOdds
//     .substring(4),
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20),
// ),
// ],
// ),
// ),
// Divider(
// color: kBlackLightColor,
// height: 3,
// thickness: 1,
// ),
// RichText(
// text: TextSpan(
// style: const TextStyle(
// fontFamily: 'Montserrat',
// fontSize: 16,
// color: Colors.black,
// ),
// children: <TextSpan>[
// TextSpan(
// text: widget.bestTicket.calcOdds
//     .substring(0, 2),
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20),
// ),
// TextSpan(
// text: widget.bestTicket.calcOdds
//     .substring(2, 4),
// ),
// TextSpan(
// text: widget.bestTicket.calcOdds
//     .substring(4),
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20),
// ),
// ],
// ),
// ),
// Divider(
// color: kBlackLightColor,
// height: 3,
// thickness: 1,
// ),
// RichText(
// text: TextSpan(
// style: const TextStyle(
// fontFamily: 'Montserrat',
// fontSize: 16,
// color: Colors.black,
// ),
// children: <TextSpan>[
// TextSpan(
// text:
// '\$${widget.bestTicket.calculatedEv}',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20),
// ),
// ],
// ),
// ),
// ],
// )
// ],
// )
// ],
// )