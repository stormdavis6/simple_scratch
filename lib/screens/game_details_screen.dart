import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_scratch/models/ticket.dart';
import 'package:simple_scratch/utils.dart';
import 'package:simple_scratch/widgets/premium_sheet.dart';
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
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: isPremium
                                ? simpleScratchTicketStats(context)
                                : simpleScratchTicketStatsBlur(context),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            color: Colors.black45,
                            height: 3,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ticketInfo(context),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            color: Colors.black45,
                            height: 3,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 15,
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
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Image.network(
                  ticket.img.replaceAll('_sqr.png', '.jpg'),
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
              );
            });
      },
      child: Column(
        children: [
          Material(
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
                  child: FadeInImage.memoryNetwork(
                    image: ticket.img,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * .5 - 8,
                    placeholder: kTransparentImage,
                    imageErrorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Icon(Icons.error);
                    },
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
                    padding:
                        EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
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
          ),
          SizedBox(
            height: 1,
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 10,
                color: Colors.grey,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Tap to Enlarge',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget newRightOfImageText(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5 - 18,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: RichText(
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
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  children: [
                    WidgetSpan(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          iconSize: 12,
                          icon: Icon(
                            Icons.info_outline,
                            color: kGreenLightColor,
                          ),
                          onPressed: () {
                            Utils.showInfoPopUp(Text('Overall Odds'),
                                Text(Utils.overallOdds), context);
                          },
                        ),
                        alignment: PlaceholderAlignment.middle),
                    TextSpan(
                      text: ' Overall Odds: ',
                    ),
                    TextSpan(
                      text: ticket.overallOdds.substring(0, 2),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    TextSpan(
                      text: ticket.overallOdds.substring(2, 4),
                    ),
                    TextSpan(
                      text: ticket.overallOdds.substring(4),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ],
                ),
              ),
              isPremium
                  ? RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        children: [
                          WidgetSpan(
                              child: IconButton(
                                splashRadius: .1,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                iconSize: 12,
                                icon: Icon(
                                  Icons.info_outline,
                                  color: kGreenLightColor,
                                ),
                                onPressed: () {},
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                            text: ' Calculated Odds: ',
                          ),
                          TextSpan(
                            text: ticket.calcOdds.substring(0, 2),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          TextSpan(
                            text: ticket.calcOdds.substring(2, 4),
                          ),
                          TextSpan(
                            text: ticket.calcOdds.substring(4),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        children: [
                          WidgetSpan(
                              child: IconButton(
                                splashRadius: .1,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                iconSize: 12,
                                icon: Icon(
                                  Icons.info_outline,
                                  color: kGreenLightColor,
                                ),
                                onPressed: () {},
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                            text: ' Calculated Odds: ',
                          ),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await showModalBottomSheet(
                                    backgroundColor: Color(0xff20201e),
                                    isScrollControlled: true,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) => PremiumSheet(),
                                  );
                                },
                              text: 'Premium',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 11,
                                  color: kGreenLightColor)),
                        ],
                      ),
                    ),
              isPremium
                  ? RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        children: [
                          WidgetSpan(
                              child: IconButton(
                                splashRadius: .1,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                iconSize: 12,
                                icon: Icon(
                                  Icons.info_outline,
                                  color: kGreenLightColor,
                                ),
                                onPressed: () {},
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                            text: ' Overall EV: ',
                          ),
                          TextSpan(
                              text: '\$${ticket.overallEv}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        children: [
                          WidgetSpan(
                              child: IconButton(
                                splashRadius: .1,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                iconSize: 12,
                                icon: Icon(
                                  Icons.info_outline,
                                  color: kGreenLightColor,
                                ),
                                onPressed: () {},
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                            text: ' Overall EV: ',
                          ),
                          TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              text: 'Premium',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 11,
                                  color: kGreenLightColor)),
                        ],
                      ),
                    ),
              isPremium
                  ? RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        children: [
                          WidgetSpan(
                              child: IconButton(
                                splashRadius: .1,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                iconSize: 12,
                                icon: Icon(
                                  Icons.info_outline,
                                  color: kGreenLightColor,
                                ),
                                onPressed: () {},
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                            text: ' Calculated EV: ',
                          ),
                          TextSpan(
                              text: '\$${ticket.calculatedEv}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        children: [
                          WidgetSpan(
                              child: IconButton(
                                splashRadius: .1,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                iconSize: 12,
                                icon: Icon(
                                  Icons.info_outline,
                                  color: kGreenLightColor,
                                ),
                                onPressed: () {},
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                            text: ' Calculated EV: ',
                          ),
                          TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              text: 'Premium',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 11,
                                  color: kGreenLightColor)),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget rightOfImageText(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5 - 18,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
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
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Top Prize',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.right,
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
                  children: [
                    TextSpan(
                      text: 'Overall Odds ',
                    ),
                    WidgetSpan(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          iconSize: 14,
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: kGreenLightColor,
                          ),
                          onPressed: () {
                            Utils.showInfoPopUp(Text('Overall Odds'),
                                Text(Utils.overallOdds), context);
                          },
                        ),
                        alignment: PlaceholderAlignment.top),
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
            ],
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

  Widget simpleScratchTicketStats(context) {
    return Material(
      elevation: 3,
      color: kBackgroundColor
      // Color(0xff20201e)
      ,
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Simple Scratch Stats',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: kGreenLightColor,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
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
                  RichText(
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
                  RichText(
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
                  ),
                ],
              ),
              Column(
                children: [
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
                          text: 'Overall EV',
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
                          text: '\$${ticket.overallEv}',
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
                          text: 'Calculated EV',
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
                          text: '\$${ticket.calculatedEv}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget simpleScratchTicketStatsBlur(context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
          backgroundColor: Color(0xff20201e),
          isScrollControlled: true,
          enableDrag: false,
          context: context,
          builder: (context) => PremiumSheet(),
        );
      },
      child: Material(
        elevation: 3,
        color: kBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Simple Scratch Stats',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: kGreenLightColor,
                                    fontFamily: 'Pacifico',
                                    fontWeight: FontWeight.w500,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
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
                            RichText(
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
                            RichText(
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
                            ),
                          ],
                        ),
                        Column(
                          children: [
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
                                    text: 'Overall EV',
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
                                    text: '\$${ticket.overallEv}',
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
                                    text: 'Calculated EV',
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
                                    text: '\$${ticket.calculatedEv}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !isPremium,
              child: GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    enableDrag: false,
                    context: context,
                    builder: (context) => PremiumSheet(),
                  );
                },
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        children: [
                          WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Icon(
                                  Icons.lock,
                                  color: kGreenLightColor,
                                  size: 18,
                                ),
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                              text: 'Premium',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: kGreenLightColor)),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Unlock Premium to view stats like Calculated Odds, Expected Ticket Value, Tickets Sold Yesterday, and more! ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget ticketInfo(context) {
    return Material(
      elevation: 3,
      color: kBackgroundColor,
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      child: Column(
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
                  text: 'Ticket Info',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Game Number',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ticket.gameNum,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Start Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ticket.launchDate,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Top Prize',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ticket.topPrize,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Claim Deadline',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ticket.claimDeadline,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'End Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ticket.endDate,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Overall Odds ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        WidgetSpan(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              iconSize: 13,
                              icon: Icon(
                                Icons.info_outline,
                                color: kGreenLightColor,
                              ),
                              onPressed: () {
                                Utils.showInfoPopUp(Text('Overall Odds'),
                                    Text(Utils.overallOdds), context);
                              },
                            ),
                            alignment: PlaceholderAlignment.middle),
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
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ticket.overallOdds,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(
          //   height: 0,
          // ),
        ],
      ),
    );
  }
}