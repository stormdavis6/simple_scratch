import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../constants.dart';
import '../models/ticket.dart';
import '../utils.dart';

//https://stackoverflow.com/questions/71769575/tabbarview-within-scrollable-page

//https://stackoverflow.com/questions/54642710/tabbarview-with-dynamic-container-height

class NewGameDetailsScreen extends StatefulWidget {
  final Ticket ticket;
  final bool isPremium;
  const NewGameDetailsScreen(
      {super.key, required this.ticket, required this.isPremium});

  @override
  State<NewGameDetailsScreen> createState() => _NewGameDetailsScreenState();
}

class _NewGameDetailsScreenState extends State<NewGameDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
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
                                            widget.ticket.img
                                                .replaceAll('_sqr.png', '.jpg'),
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: kGreenLightColor,
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder: (BuildContext context,
                                                Object exception,
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
                                              image: widget.ticket.img,
                                              fit: BoxFit.fill,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5 -
                                                  8,
                                              placeholder: kTransparentImage,
                                              imageErrorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return const Icon(Icons.error);
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            width: widget.ticket.price
                                                        .toString()
                                                        .length ==
                                                    1
                                                ? 23
                                                : 31,
                                            top: 0.0,
                                            left: 0.0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: kBlackLightColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3.0,
                                                  horizontal: 3.0),
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
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * .5 - 8,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: (MediaQuery.of(context).size.width *
                                            .05 -
                                        8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              text: widget.ticket.name,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationThickness: 1,
                                                  decorationColor:
                                                      kGreenLightColor),
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
                                              text: 'Top Prize',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
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
                                              text: widget.ticket.topPrize,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16),
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
                                                    Utils.showInfoPopUp(
                                                        Text('Overall Odds'),
                                                        Text(Utils.overallOdds),
                                                        context);
                                                  },
                                                ),
                                                alignment:
                                                    PlaceholderAlignment.top),
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
                                              text: widget.ticket.overallOdds,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: TabBar(
                              labelColor: kGreenLightColor,
                              isScrollable: true,
                              indicatorColor: kBlackLightColor,
                              controller: _controller,
                              tabs: [
                                Tab(
                                  text: 'Simple Scratch Stats',
                                ),
                                Tab(
                                  text: 'Ticket Info',
                                ),
                                Tab(
                                  text: 'Prizes',
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 16,
                            child: DefaultTabController(
                              length: 2,
                              child: TabBarView(
                                controller: _controller,
                                children: [
                                  Card(
                                    child: Center(
                                      child: Material(
                                        elevation: 3,
                                        color: kBackgroundColor
                                        // Color(0xff20201e)
                                        ,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                'Calculated Odds',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: widget.ticket
                                                                .calcOdds,
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
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                'Calculated Prob',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                '${widget.ticket.calcProb}%',
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
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                '\$${widget.ticket.overallEv}',
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
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                'Calculated EV',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                '\$${widget.ticket.calculatedEv}',
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
                                  ),
                                  Center(
                                      child: Card(
                                    child: Material(
                                      elevation: 3,
                                      color: kBackgroundColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'Game Number',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: widget
                                                              .ticket.gameNum,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'Start Date',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: widget.ticket
                                                              .launchDate,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'Top Prize',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: widget
                                                              .ticket.topPrize,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              'Claim Deadline',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: widget.ticket
                                                              .claimDeadline,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'End Date',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: widget
                                                              .ticket.endDate,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
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
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'Overall Odds ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        WidgetSpan(
                                                            child: IconButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              constraints:
                                                                  BoxConstraints(),
                                                              iconSize: 13,
                                                              icon: Icon(
                                                                Icons
                                                                    .info_outline,
                                                                color:
                                                                    kGreenLightColor,
                                                              ),
                                                              onPressed: () {
                                                                Utils.showInfoPopUp(
                                                                    Text(
                                                                        'Overall Odds'),
                                                                    Text(Utils
                                                                        .overallOdds),
                                                                    context);
                                                              },
                                                            ),
                                                            alignment:
                                                                PlaceholderAlignment
                                                                    .middle),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: widget.ticket
                                                              .overallOdds,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
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
                                    ),
                                  )),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        child: Material(
                                          elevation: 3,
                                          color: kBackgroundColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Table(
                                                children: prizesTableRows(),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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

  List<TableRow> prizesTableRows() {
    int rows = widget.ticket.prizes.length;
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
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text(widget.ticket.prizes[i]['Value'])),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text(widget.ticket.prizes[i]['Odds'])),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text(widget.ticket.prizes[i]['Total'])),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text(widget.ticket.prizes[i]['Remaining'])),
            ),
          ],
        ),
      );
    }
    return listOfRows;
  }
}