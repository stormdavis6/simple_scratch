import 'package:flutter/material.dart';

class GameCardCarousel extends StatefulWidget {
  final String src;
  const GameCardCarousel({Key? key, required this.src}) : super(key: key);

  @override
  State<GameCardCarousel> createState() => _GameCardCarouselState();
}

class _GameCardCarouselState extends State<GameCardCarousel> {
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
                  widget.src,
                  fit: BoxFit.fill,
                  width: 320,
                  height: 320,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 320,
          decoration: BoxDecoration(
            color: Color(0xfffffdee),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 10.0,
              ),
            ],
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
                            text: '\$20',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                            text: '1 ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'in ',
                          ),
                          TextSpan(
                            text: '3.14',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                padding: EdgeInsets.fromLTRB(3, 0, 3, 5),
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
                            text: '\$1,000',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                            text: '1 ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'in ',
                          ),
                          TextSpan(
                            text: '15.9',
                            style: TextStyle(fontWeight: FontWeight.bold),
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