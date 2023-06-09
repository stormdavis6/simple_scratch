import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';

import '../models/ticket.dart';

class GameCardSmall extends StatefulWidget {
  final Ticket ticket;
  const GameCardSmall({Key? key, required this.ticket}) : super(key: key);

  @override
  State<GameCardSmall> createState() => _GameCardSmallState();
}

class _GameCardSmallState extends State<GameCardSmall> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Container(
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
                  Positioned(
                    width: widget.ticket.price.toString().length == 1 ? 23 : 31,
                    top: 0.0,
                    left: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kGreenLightColor,
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
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Material(
          elevation: 3,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
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
                ),
                Divider(
                  color: Colors.black,
                  height: 3,
                  thickness: 1,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Calculated Odds: ',
                        ),
                        TextSpan(
                          text: widget.ticket.calcOdds.substring(0, 2),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        TextSpan(
                          text: widget.ticket.calcOdds.substring(2, 4),
                        ),
                        TextSpan(
                          text: widget.ticket.calcOdds.substring(4),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
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