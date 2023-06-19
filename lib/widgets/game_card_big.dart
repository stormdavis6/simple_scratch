import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';

import '../models/ticket.dart';

class GameCardBig extends StatefulWidget {
  final Ticket ticket;
  const GameCardBig({Key? key, required this.ticket}) : super(key: key);

  @override
  State<GameCardBig> createState() => _GameCardBigState();
}

class _GameCardBigState extends State<GameCardBig> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Material(
            elevation: 10,
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
                  ),
                ),
              ],
            ),
          ),
        ),
        Material(
          elevation: 6,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
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
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Ticket Price: ',
                            ),
                            TextSpan(
                              text: '\$${widget.ticket.price.toString()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Overall Odds: ',
                            ),
                            TextSpan(
                              text: widget.ticket.overallOdds.substring(0, 2),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            TextSpan(
                              text: widget.ticket.overallOdds.substring(2, 4),
                            ),
                            TextSpan(
                              text: widget.ticket.overallOdds.substring(4),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 3,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Top Prize: ',
                            ),
                            TextSpan(
                              text: widget.ticket.topPrize,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Calculated Odds: ',
                            ),
                            TextSpan(
                              text: widget.ticket.overallOdds.substring(0, 2),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            TextSpan(
                              text: widget.ticket.overallOdds.substring(2, 4),
                            ),
                            TextSpan(
                              text: widget.ticket.overallOdds.substring(4),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
    );
  }
}