import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';
import 'package:simple_scratch/database/ticket_database.dart';
import 'package:simple_scratch/screens/games_filter_screen.dart';
import 'package:simple_scratch/widgets/bottom_nav_bar.dart';
import 'package:simple_scratch/widgets/game_card_small.dart';
import 'package:simple_scratch/widgets/games_carousel.dart';
import '../models/filterItem.dart';
import '../models/ticket.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<FilterItem> selectedFiltersList = [];
  List<Ticket> bestTickets = [];
  List<Ticket> allTickets = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getTickets();
  }

  Future getTickets() async {
    setState(() {
      isLoading = true;
    });
    TicketDatabase ticketDatabase = TicketDatabase();
    await Firebase.initializeApp();
    await ticketDatabase.getBestTicketsFromFirestore();
    bestTickets = ticketDatabase.getBestTickets();
    print('best tickets list size: ${bestTickets.length}');
    bestTickets.forEach((element) {
      print(element.name);
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: kGreenLightColor,
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              backgroundColor: kBackgroundColor,
              bottomNavigationBar: const BottomNavBar(
                selectedIndex: 0,
              ),
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                          ),
                          Stack(
                            children: [
                              Positioned.directional(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  'Scratch-Offs',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 2
                                            ..color = kGreenOliveColor,
                                          fontFamily: 'Pacifico'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                'Scratch-Offs',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: kYellowLightColor,
                                      fontFamily: 'Pacifico',
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () async {
                              dynamic result = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return GamesFilterScreen(
                                  selectedFiltersListPassed:
                                      selectedFiltersList,
                                );
                              }));
                              if (result != null) {
                                selectedFiltersList = result;
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.filter_list_sharp,
                              color: selectedFiltersList.isNotEmpty
                                  ? kGreenLightColor
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: ListView(
                          children: [
                            selectedFiltersList.isEmpty
                                ? SizedBox(
                                    height: 345,
                                    child: GamesCarousel(
                                      bestTickets: bestTickets,
                                    ),
                                  )
                                : SizedBox(
                                    width: 150,
                                    height: 35,
                                    child: ListView.builder(
                                        physics: ScrollPhysics(),
                                        itemCount: selectedFiltersList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(1, 0, 5, 0),
                                            child: TextButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    kBackgroundColor,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    side: BorderSide(
                                                        color:
                                                            kGreenLightColor)),
                                              ),
                                              child: Text(
                                                selectedFiltersList[index]
                                                    .filterText,
                                                style: TextStyle(
                                                    color: kGreenLightColor,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            GridView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: bestTickets.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GameCardSmall(
                                    ticket: bestTickets[index],
                                  );
                                }),
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
}