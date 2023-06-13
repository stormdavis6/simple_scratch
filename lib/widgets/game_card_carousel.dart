import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_scratch/constants.dart';

import '../models/ticket.dart';

class GameCardCarousel extends StatefulWidget {
  final Ticket ticket;
  const GameCardCarousel({Key? key, required this.ticket}) : super(key: key);

  @override
  State<GameCardCarousel> createState() => _GameCardCarouselState();
}

class _GameCardCarouselState extends State<GameCardCarousel> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Blur(
      blur: 50,
      blurColor: kGreenLightColor,
      overlay: TextButton(
        onPressed: () {},
        child: Text(
          'Upgrade to premium to view',
          style: TextStyle(color: Color(0xff363636)),
        ),
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
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
                      widget.ticket.img,
                      fit: BoxFit.fill,
                      width: 320,
                      height: 320,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        // return Center(
                        //   child: CircularProgressIndicator(
                        //     color: kGreenLightColor,
                        //     value: loadingProgress.expectedTotalBytes != null
                        //         ? loadingProgress.cumulativeBytesLoaded /
                        //             loadingProgress.expectedTotalBytes!
                        //         : null,
                        //   ),
                        // );
                        return Center(
                          child: SizedBox(
                            width: 320.0,
                            height: 320.0,
                            child: Shimmer.fromColors(
                              baseColor: kBackgroundColor,
                              highlightColor: kGreenLightColor,
                              child: Container(
                                color: kBackgroundColor,
                              ),
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
                    width: widget.ticket.price.toString().length == 1 ? 29 : 41,
                    top: 0.0,
                    left: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF363636),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                      child: Text(
                        '\$${widget.ticket.price.toString()}',
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
          Material(
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
                    padding: EdgeInsets.fromLTRB(3, 0, 3, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // RichText(
                        //   text: TextSpan(
                        //     style: const TextStyle(
                        //       fontFamily: 'Montserrat',
                        //       fontSize: 14,
                        //       color: Colors.black,
                        //     ),
                        //     children: <TextSpan>[
                        //       TextSpan(
                        //         text: 'Ticket Price: ',
                        //       ),
                        //       TextSpan(
                        //         text: '\$${widget.ticket.price.toString()}',
                        //         style: TextStyle(fontWeight: FontWeight.bold),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Overall Odds: ',
                              ),
                              TextSpan(
                                text: widget.ticket.overallOdds.substring(0, 2),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              TextSpan(
                                text: widget.ticket.overallOdds.substring(2, 4),
                              ),
                              TextSpan(
                                text: widget.ticket.overallOdds.substring(4),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xff363636),
                    height: 3,
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(3, 0, 3, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // RichText(
                        //   text: TextSpan(
                        //     style: const TextStyle(
                        //       fontFamily: 'Montserrat',
                        //       fontSize: 14,
                        //       color: Colors.black,
                        //     ),
                        //     children: <TextSpan>[
                        //       TextSpan(
                        //         text: 'Top Prize: ',
                        //       ),
                        //       TextSpan(
                        //         text: widget.ticket.topPrize,
                        //         style: TextStyle(fontWeight: FontWeight.bold),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Calculated Odds: ',
                              ),
                              TextSpan(
                                text: widget.ticket.calcOdds.substring(0, 2),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              TextSpan(
                                text: widget.ticket.calcOdds.substring(2, 4),
                              ),
                              TextSpan(
                                text: widget.ticket.calcOdds.substring(4),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
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
        ],
      ),
    );
  }
}