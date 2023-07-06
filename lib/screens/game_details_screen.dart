import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_scratch/models/ticket.dart';
import 'package:transparent_image/transparent_image.dart';

import '../constants.dart';

class GameDetailsScreen extends StatelessWidget {
  final Ticket ticket;
  final bool isPremium;
  const GameDetailsScreen(
      {super.key, required this.ticket, required this.isPremium});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Stack(
                    children: [
                      Positioned.directional(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'Scratch-Off Details',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = kGreenOliveColor,
                                  fontFamily: 'Pacifico'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'Scratch-Off Details',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: kYellowLightColor,
                              fontFamily: 'Pacifico',
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                  ),
                ],
              ),
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    scrollbarTheme: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all(kBlackLightColor),
                        crossAxisMargin: -6),
                  ),
                  child: Scrollbar(
                    controller: ScrollController(),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ticketImage(context),
                              SizedBox(
                                width: 10,
                              ),
                              rightOfImageText(context),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            color: Colors.black45,
                            height: 3,
                            thickness: 1,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Pacifico',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Prizes',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                              elevation: 3,
                              color: kBackgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Table(
                                    children: prizesTableRows(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Text(
                                  //   '*Approximate odds of winning and the number of prizes including breakeven prizes is established at the time of printing. Chances of winning will change as prizes are won.',
                                  //   textAlign: TextAlign.left,
                                  //   style: TextStyle(fontSize: 8),
                                  // ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: Colors.black45,
                            height: 3,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                              elevation: 3,
                              color: kBackgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: infoTable(),
                            ),
                          ),
                          // Divider(
                          //   color: kBlackLightColor,
                          //   height: 3,
                          //   thickness: 1,
                          // ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ticketImage(context) {
    return Material(
      elevation: 3,
      color: kBackgroundColor,
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            child: GestureDetector(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        elevation: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Image.network(
                          ticket.img.replaceAll('_sqr.png', '.jpg'),
                          // filterQuality: FilterQuality.high,
                        ),
                      );
                    });
              },
              child: FadeInImage.memoryNetwork(
                image: ticket.img.replaceAll('_sqr.png', '.jpg'),
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * .5 - 8,
                height: ticket.price <= 5 ? null : 350,
                placeholder: kTransparentImage,
                imageErrorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
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
          ),
          Positioned(
            width: ticket.price.toString().length == 1 ? 23 : 31,
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
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
              child: Text(
                '\$${ticket.price.toString()}',
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
    );
  }

  Widget rightOfImageText(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Material(
          elevation: 3,
          color: kBackgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .5 - 18,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ticket.name,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 1,
                              decorationColor: kGreenLightColor)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Top Prize',
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
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ticket.topPrize,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Overall Odds',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ticket.overallOdds,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Calculated Odds',
                      ),
                    ],
                  ),
                ),
                isPremium
                    ? RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ticket.calcOdds,
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: 'Premium',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: kGreenLightColor)),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Calculated Prob',
                      ),
                    ],
                  ),
                ),
                isPremium
                    ? RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${ticket.calcProb}%',
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: 'Premium',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: kGreenLightColor)),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<TableRow> prizesTableRows() {
    int rows = ticket.prizes.length;
    List<TableRow> listOfRows = [];
    TextStyle headerStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    listOfRows.add(TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
          child: Text(
            'Value',
            style: headerStyle,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
          child: Text(
            'Odds 1 in*',
            style: headerStyle,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
          child: Text(
            'Total',
            style: headerStyle,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
          child: Text(
            'Remaining',
            style: headerStyle,
          ),
        ),
      ),
    ]));
    for (int i = 0; i < rows; i++) {
      listOfRows.add(
        TableRow(
          decoration: BoxDecoration(
              color: i.isOdd ? Color(0x3f6d9967) : kBackgroundColor),
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(child: Text(ticket.prizes[i]['Value'])),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(child: Text(ticket.prizes[i]['Odds'])),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(child: Text(ticket.prizes[i]['Total'])),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(child: Text(ticket.prizes[i]['Remaining'])),
            ),
          ],
        ),
      );
    }
    return listOfRows;
  }

  Widget infoTable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Start Date',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ticket.launchDate,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Top Prize',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ticket.topPrize,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Calculated Probability',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            isPremium
                ? RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${ticket.calcProb}%',
                        ),
                      ],
                    ),
                  )
                : RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            text: 'Premium',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: kGreenLightColor)),
                      ],
                    ),
                  ),
          ],
        ),
        Column(
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'End Date',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ticket.endDate,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Overall Odds',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ticket.overallOdds,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Calculated Odds',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            isPremium
                ? RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ticket.calcOdds,
                        ),
                      ],
                    ),
                  )
                : RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            text: 'Premium',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: kGreenLightColor)),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}