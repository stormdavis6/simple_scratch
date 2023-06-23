import 'package:blur/blur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_scratch/constants.dart';
import 'package:simple_scratch/database/ticket_database.dart';
import 'package:simple_scratch/screens/games_filter_screen.dart';
import 'package:simple_scratch/widgets/bottom_nav_bar.dart';
import 'package:simple_scratch/widgets/game_card_small.dart';
import 'package:simple_scratch/widgets/games_carousel.dart';
import '../models/filterItem.dart';
import '../models/ticket.dart';
import '../services/auth_service.dart';
import '../widgets/side_navigation_drawer.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<FilterItem> selectedFiltersList = [];
  List<Ticket> bestTickets = [];
  List<Ticket> allTickets = [];
  List<Ticket> duplicateAllTickets = [];
  List<Ticket> allTicketsFiltered = [];
  List<Ticket> duplicateAllTicketsFiltered = [];
  bool isLoading = false;
  bool searchIsFocused = false;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    getTickets();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future getTickets() async {
    setState(() {
      isLoading = true;
    });

    TicketDatabase ticketDatabase = TicketDatabase();
    await ticketDatabase.getBestTicketsFromFirestore();
    bestTickets = ticketDatabase.getBestTickets();
    await ticketDatabase.getAllTicketsFromFirestore();
    allTickets = ticketDatabase.getAllTickets();
    duplicateAllTickets = allTickets;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allTickets.forEach((ticket) {
        precacheImage(NetworkImage(ticket.img), context);
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  void filterTickets() {
    allTicketsFiltered = allTickets;
    List<Ticket> tempFilteredTicketsListPrice = [];
    List<Ticket> tempFilteredListTopPrize = [];
    for (var item in selectedFiltersList) {
      if (item.filterType == 1) {
        allTicketsFiltered
            .where((ticket) =>
                ticket.price ==
                int.parse(item.filterText.replaceAll(RegExp(r"\D"), "")))
            .toList()
            .forEach((ticket) {
          tempFilteredTicketsListPrice.add(ticket);
        });
      } else {
        for (var ticket in allTicketsFiltered) {
          int topPrize =
              int.parse(ticket.topPrize.replaceAll(RegExp(r"\D"), ""));
          //1M+ top prize
          if (item.filterText == '1M+') {
            if (topPrize >= 1000000) {
              tempFilteredListTopPrize.add(ticket);
            }
          }
          //500k+ top prize
          else if (item.filterText == '\$500k+') {
            if (topPrize >= 500000) {
              tempFilteredListTopPrize.add(ticket);
            }
          }
          //250k - 500k top prize
          else if (item.filterText == '\$250k - \$500k') {
            if (topPrize >= 250000 && topPrize <= 500000) {
              tempFilteredListTopPrize.add(ticket);
            }
          }
          //100k - 250k top prize
          else if (item.filterText == '\$100k - \$250k') {
            if (topPrize >= 100000 && topPrize <= 250000) {
              tempFilteredListTopPrize.add(ticket);
            }
          }
          //50k - 100k top prize
          else if (item.filterText == '\$50k - \$100k') {
            if (topPrize >= 50000 && topPrize <= 100000) {
              tempFilteredListTopPrize.add(ticket);
            }
          }
          //5k - 50k top prize
          else if (item.filterText == '\$5k - \$50k') {
            if (topPrize >= 5000 && topPrize <= 50000) {
              tempFilteredListTopPrize.add(ticket);
            }
          }
          //5k - 50k top prize
          else if (item.filterText == 'Less Than \$5k') {
            if (topPrize < 5000) {
              tempFilteredListTopPrize.add(ticket);
            }
          }
        }
      }
    }

    List<Ticket> filteredTicketsIntersection = [];
    if (tempFilteredTicketsListPrice.isEmpty) {
      filteredTicketsIntersection = tempFilteredListTopPrize;
    } else {
      filteredTicketsIntersection = tempFilteredTicketsListPrice;
      if (tempFilteredListTopPrize.isNotEmpty) {
        filteredTicketsIntersection.removeWhere(
            (element) => !tempFilteredListTopPrize.contains(element));
      }
    }

    filteredTicketsIntersection.sort((a, b) => b.price.compareTo(a.price));
    allTicketsFiltered = filteredTicketsIntersection;
    duplicateAllTicketsFiltered = filteredTicketsIntersection;
  }

  //function to search through list of exercises
  void SearchTickets(String query) {
    setState(() {
      if (selectedFiltersList.isNotEmpty) {
        allTicketsFiltered = duplicateAllTicketsFiltered
            .where((ticket) =>
                ticket.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        allTickets = duplicateAllTickets
            .where((ticket) =>
                ticket.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      allTickets.sort((a, b) => b.price.compareTo(a.price));
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>(); // Create a key
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
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
              key: _scaffoldKey,
              backgroundColor: kBackgroundColor,
              bottomNavigationBar: const BottomNavBar(
                selectedIndex: 0,
              ),
              drawer: SideNavigationDrawer(),
              drawerEdgeDragWidth: MediaQuery.of(context).size.width * .15,
              // endDrawer: GamesFilterScreen(
              //   selectedFiltersListPassed: selectedFiltersList,
              // ),
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
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
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
                                  'Simple Scratch',
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
                                'Simple Scratch',
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
                          Stack(
                            children: [
                              selectedFiltersList.isNotEmpty
                                  ? Positioned(
                                      width: 8,
                                      height: 8,
                                      top: 9.0,
                                      right: 9.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kYellowLightColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                              IconButton(
                                onPressed: () async {
                                  final result = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return GamesFilterScreen(
                                      selectedFiltersListPassed:
                                          selectedFiltersList,
                                    );
                                  }));
                                  setState(() {
                                    if (result != null && result != -1) {
                                      selectedFiltersList = result;
                                      selectedFiltersList
                                          .sort((a, b) => b.id.compareTo(a.id));
                                      filterTickets();
                                      SearchTickets(searchController.text);
                                    } else {
                                      allTicketsFiltered = allTickets;
                                      selectedFiltersList = [];
                                      SearchTickets(searchController.text);
                                    }
                                  });
                                  // _scaffoldKey.currentState?.openEndDrawer();
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
                        ],
                      ),
                      Flexible(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            scrollbarTheme: ScrollbarThemeData(
                                thumbColor:
                                    MaterialStateProperty.all(kBlackLightColor),
                                crossAxisMargin: -6),
                          ),
                          child: Scrollbar(
                            child: ListView(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              children: [
                                selectedFiltersList.isEmpty &&
                                        !searchIsFocused &&
                                        searchController.text.isEmpty
                                    ? SizedBox(
                                        height: 345,
                                        child: GamesCarousel(
                                          bestTickets: bestTickets,
                                        ),
                                      )
                                    : SizedBox(
                                        width: 150,
                                        height: selectedFiltersList.isNotEmpty
                                            ? 35
                                            : 0,
                                        child: Scrollbar(
                                          child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount:
                                                  selectedFiltersList.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      1, 0, 5, 0),
                                                  child: Stack(
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          selectedFiltersList
                                                              .removeAt(index);
                                                          filterTickets();
                                                          SearchTickets(
                                                              searchController
                                                                  .text);
                                                          setState(() {});
                                                        },
                                                        style: TextButton
                                                            .styleFrom(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          foregroundColor:
                                                              kGreenLightColor,
                                                          backgroundColor:
                                                              kGreenLightColor,
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              side: BorderSide(
                                                                  color:
                                                                      kGreenLightColor)),
                                                        ),
                                                        child: Text(
                                                          selectedFiltersList[
                                                                          index]
                                                                      .filterText
                                                                      .length <=
                                                                  3
                                                              ? selectedFiltersList[
                                                                      index]
                                                                  .filterText
                                                              : '     ${selectedFiltersList[index].filterText}     ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          width: 15,
                                                          height: 15,
                                                          top: 0.0,
                                                          right: 0.0,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              print(
                                                                  'Button pressed at index $index');
                                                              selectedFiltersList
                                                                  .removeAt(
                                                                      index);
                                                              filterTickets();
                                                              SearchTickets(
                                                                  searchController
                                                                      .text);
                                                              setState(() {});
                                                              print(
                                                                  'filter list size: ${selectedFiltersList.length}');
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
                                                              size: 12,
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                //This container is the search bar
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 0),
                                  decoration: BoxDecoration(
                                    color: kBackgroundColor,
                                    border: Border.all(
                                        color: searchIsFocused
                                            ? kGreenLightColor
                                            : Colors.grey[700]!),
                                    borderRadius: BorderRadius.circular(29.5),
                                  ),
                                  child: TextField(
                                    controller: searchController,
                                    cursorColor: kGreenLightColor,
                                    decoration: InputDecoration(
                                      hintText: "Search",
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.grey[700],
                                      ),
                                      border: InputBorder.none,
                                      suffixIcon: searchController.text.isEmpty
                                          ? const SizedBox(
                                              width: 0,
                                              height: 0,
                                            )
                                          : IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.grey[700],
                                              ),
                                              onPressed: () {
                                                searchController.clear();
                                                SearchTickets('');
                                              }),
                                    ),
                                    onChanged: (query) {
                                      SearchTickets(query);
                                    },
                                    onTap: () {
                                      setState(() {
                                        searchIsFocused = true;
                                      });
                                    },
                                    onSubmitted: (query) {
                                      setState(() {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        searchIsFocused = false;
                                      });
                                    },
                                    onTapOutside: (pointer) {
                                      setState(() {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        searchIsFocused = false;
                                      });
                                    },
                                  ),
                                ),
                                allTickets.isEmpty ||
                                        (allTicketsFiltered.isEmpty &&
                                            selectedFiltersList.isNotEmpty)
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.search_off_rounded,
                                              size: 70,
                                            ),
                                            Text(
                                              'Hmmmm, we couldn\'t find any results.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              selectedFiltersList.isNotEmpty
                                                  ? 'Please check your spelling or try removing some filters.'
                                                  : 'Please check your spelling or try different keywords.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontFamily: 'Montserrat'),
                                            )
                                          ],
                                        ),
                                      )
                                    : GridView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200,
                                                childAspectRatio: 1,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemCount: selectedFiltersList.isEmpty
                                            ? allTickets.length
                                            : allTicketsFiltered.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return GameCardSmall(
                                            ticket: selectedFiltersList.isEmpty
                                                ? allTickets[index]
                                                : allTicketsFiltered[index],
                                          );
                                        }),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
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