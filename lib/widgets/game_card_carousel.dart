import 'package:flutter/material.dart';
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
    return Column(
      children: [
        Expanded(
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
                    return Center(
                      child: CircularProgressIndicator(
                        color: kGreenLightColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
              // Positioned(
              //   width: widget.ticket.price.toString().length == 1 ? 29 : 41,
              //   top: 0.0,
              //   left: 0.0,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: kGreenLightColor,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(8),
              //         bottomRight: Radius.circular(8),
              //       ),
              //     ),
              //     padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
              //     child: Text(
              //       '\$${widget.ticket.price.toString()}',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          width: 320,
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
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
      ],
    );
  }
}
