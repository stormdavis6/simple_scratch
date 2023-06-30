import 'package:blur/blur.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_scratch/constants.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/ticket.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class GameCardSmall extends StatefulWidget {
  final Ticket ticket;
  const GameCardSmall({Key? key, required this.ticket}) : super(key: key);

  @override
  State<GameCardSmall> createState() => _GameCardSmallState();
}

class _GameCardSmallState extends State<GameCardSmall> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    bool isPremium = false;
    if (user != null) {
      isPremium = user.isPremium;
    }
    return GestureDetector(
      onTap: () {
        print('${widget.ticket.name} tapped!');
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
                    child: FadeInImage.memoryNetwork(
                      image: widget.ticket.img,
                      fit: BoxFit.fill,
                      width: 320,
                      height: 320, placeholder: kTransparentImage,
                      imageErrorBuilder: (BuildContext context,
                          Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error);
                      },
                      // loadingBuilder: (BuildContext context, Widget child,
                      //     ImageChunkEvent? loadingProgress) {
                      //   if (loadingProgress == null) return child;
                      //   return Center(
                      //     child: CircularProgressIndicator(
                      //       color: kGreenLightColor,
                      //       value: loadingProgress.expectedTotalBytes != null
                      //           ? loadingProgress.cumulativeBytesLoaded /
                      //               loadingProgress.expectedTotalBytes!
                      //           : null,
                      //     ),
                      //   );
                      // },
                      // errorBuilder: (BuildContext context, Object exception,
                      //     StackTrace? stackTrace) {
                      //   return const Icon(Icons.error);
                      // },
                    ),
                  ),
                  Positioned(
                    width: widget.ticket.price.toString().length == 1 ? 23 : 31,
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
                    color: kBlackLightColor,
                    height: 3,
                    thickness: 1,
                  ),
                  isPremium
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Calculated Odds: ',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: widget.ticket.calcOdds
                                          .substring(0, 2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: widget.ticket.calcOdds
                                          .substring(2, 4),
                                    ),
                                    TextSpan(
                                      text: widget.ticket.calcOdds.substring(4),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Calculated Odds: ',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: RichText(
                                  text: TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      text: 'Premium',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          color: kGreenLightColor))),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 1,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}