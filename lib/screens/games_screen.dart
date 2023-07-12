import 'dart:io';

import 'package:blur/blur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:simple_scratch/constants.dart';
import 'package:simple_scratch/database/ticket_database.dart';
import 'package:simple_scratch/models/sort_item.dart';
import 'package:simple_scratch/services/ad_service.dart';
import 'package:simple_scratch/widgets/bottom_nav_bar.dart';
import 'package:simple_scratch/widgets/game_card_small.dart';
import 'package:simple_scratch/widgets/games_carousel.dart';
import 'package:simple_scratch/widgets/games_filter_sheet.dart';
import '../models/filter_item.dart';
import '../models/ticket.dart';
import '../utils.dart';
import '../widgets/games_sort_sheet.dart';
import '../widgets/side_navigation_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<FilterItem> selectedFiltersList = [];
  SortItem selectedSortItem = SortItem(sortText: 'Ticket Price Desc', id: 2);
  List<Ticket> bestTickets = [];
  List<Ticket> allTickets = [];
  List<Ticket> duplicateAllTickets = [];
  List<Ticket> allTicketsFiltered = [];
  List<Ticket> duplicateAllTicketsFiltered = [];
  intl.DateFormat formatter = intl.DateFormat('MMddyyyy');
  late DateTime pullDate;
  bool isLoading = false;
  bool searchIsFocused = false;
  late TextEditingController searchController;
  late bool isPremium = false;

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();

    getTickets();
    searchController = TextEditingController();

    //Load Banner Ad
    BannerAd(
      adUnitId: AdService.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    searchController.dispose();

    _bannerAd?.dispose();
    super.dispose();
  }

  Future getTickets() async {
    setState(() {
      isLoading = true;
    });

    TicketDatabase ticketDatabase = TicketDatabase();

    pullDate = DateTime.parse(formatter.format(ticketDatabase.getESTTime()));

    print('Getting best tickets from DB');
    await ticketDatabase.getBestTicketsFromFirestore();
    bestTickets = ticketDatabase.getBestTickets();

    print('Getting all tickets from DB');
    await ticketDatabase.getAllTicketsFromFirestore();
    allTickets = ticketDatabase.getAllTickets();
    duplicateAllTickets = allTickets;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.getIdToken(true);
      print('Getting if user is premium');
      final idTokenResult = await user.getIdTokenResult();
      isPremium = idTokenResult.claims?['stripeRole'] != null ? true : false;
      print(isPremium);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      allTickets.forEach((ticket) {
        precacheImage(NetworkImage(ticket.img), context);
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      allTickets.forEach((ticket) {
        precacheImage(
            NetworkImage(ticket.img.replaceAll('_sqr.png', '.jpg')), context);
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  void sortTickets(List<Ticket> tickets) {
    //Ticket Price Asc
    if (selectedSortItem.id == 1) {
      tickets.sort((a, b) {
        int cmp = a.price.compareTo(b.price);
        if (cmp != 0) return cmp;
        return a.name.compareTo(b.name);
      });
    }
    //Ticket Price Desc
    else if (selectedSortItem.id == 2) {
      tickets.sort((a, b) {
        int cmp = b.price.compareTo(a.price);
        if (cmp != 0) return cmp;
        return a.name.compareTo(b.name);
      });
    }
    //Top Prize Asc
    else if (selectedSortItem.id == 3) {
      tickets.sort((a, b) {
        int cmp = int.parse(a.topPrize.replaceAll(RegExp(r"\D"), ""))
            .compareTo(int.parse(b.topPrize.replaceAll(RegExp(r"\D"), "")));
        if (cmp != 0) return cmp;
        return a.name.compareTo(b.name);
      });
    }
    //Top Prize Desc
    else if (selectedSortItem.id == 4) {
      tickets.sort((a, b) {
        int cmp = int.parse(b.topPrize.replaceAll(RegExp(r"\D"), ""))
            .compareTo(int.parse(a.topPrize.replaceAll(RegExp(r"\D"), "")));
        if (cmp != 0) return cmp;
        return a.name.compareTo(b.name);
      });
    }
    //Overall Odds Asc
    else if (selectedSortItem.id == 5) {
      tickets.sort((a, b) {
        int cmp = double.parse(a.overallOdds.substring(5))
            .compareTo(double.parse(b.overallOdds.substring(5)));
        if (cmp != 0) return cmp;
        return a.name.compareTo(b.name);
      });
    }
    //Overall Odds Desc
    else if (selectedSortItem.id == 6) {
      tickets.sort((a, b) {
        int cmp = double.parse(b.overallOdds.substring(5))
            .compareTo(double.parse(a.overallOdds.substring(5)));
        if (cmp != 0) return cmp;
        return a.name.compareTo(b.name);
      });
    }
    //Calculated Odds Asc
    else if (selectedSortItem.id == 7) {
      tickets.sort((a, b) {
        int cmp = double.parse(a.calcOdds.substring(5))
            .compareTo(double.parse(b.calcOdds.substring(5)));
        if (cmp != 0) return cmp;
        return a.name.compareTo(b.name);
      });
    }
    //Calculated Odds Desc
    else if (selectedSortItem.id == 8) {
      tickets.sort((a, b) {
        int cmp = double.parse(b.calcOdds.substring(5))
            .compareTo(double.parse(a.calcOdds.substring(5)));
        if (cmp != 0) return cmp;
        return a.name.compareTo(b.name);
      });
    }
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

    sortTickets(filteredTicketsIntersection);
    //filteredTicketsIntersection.sort((a, b) => b.price.compareTo(a.price));
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
      sortTickets(allTickets);
      //allTickets.sort((a, b) => b.price.compareTo(a.price));
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>(); // Create a key
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: kGreenLightColor,
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              if (!_scaffoldKey.currentState!.isDrawerOpen) {
                _scaffoldKey.currentState!.openDrawer();
                return false;
              }
              return true;
            },
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: kBackgroundColor,
              // bottomNavigationBar: const BottomNavBar(
              //   selectedIndex: 0,
              // ),
              drawer: SideNavigationDrawer(
                isPremium: isPremium,
              ),
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
                                  final result = await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: kBackgroundColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) => GamesFilterSheet(
                                          selectedFiltersListPassed:
                                              selectedFiltersList));
                                  // await Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return GamesFilterScreen(
                                  //     selectedFiltersListPassed:
                                  //         selectedFiltersList,
                                  //   );
                                  // }));
                                  setState(() {
                                    if (result != null) {
                                      selectedFiltersList = result;
                                      selectedFiltersList
                                          .sort((a, b) => b.id.compareTo(a.id));
                                      filterTickets();
                                      SearchTickets(searchController.text);
                                    }
                                    // else {
                                    //   allTicketsFiltered = allTickets;
                                    //   selectedFiltersList = [];
                                    //   SearchTickets(searchController.text);
                                    // }
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
                      // _bannerAd != null && !isPremium
                      //     ? Align(
                      //         alignment: Alignment.topCenter,
                      //         child: Container(
                      //           width: _bannerAd!.size.width.toDouble(),
                      //           height: _bannerAd!.size.height.toDouble(),
                      //           child: AdWidget(ad: _bannerAd!),
                      //         ),
                      //       )
                      //     : const SizedBox(
                      //         height: 0,
                      //         width: 0,
                      //       ),
                      Flexible(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            scrollbarTheme: ScrollbarThemeData(
                                thumbColor:
                                    MaterialStateProperty.all(kBlackLightColor),
                                crossAxisMargin: -6),
                          ),
                          child: Scrollbar(
                            controller: ScrollController(),
                            child: Stack(
                              children: [
                                RefreshIndicator(
                                  backgroundColor: kBackgroundColor,
                                  color: kGreenLightColor,
                                  onRefresh: () {
                                    if (pullDate.compareTo(DateTime.parse(
                                            formatter.format(TicketDatabase()
                                                .getESTTime()))) <
                                        0) {
                                      return getTickets();
                                    } else {
                                      // Utils.showSnackBar(
                                      //     'All tickets are up to date',
                                      //     context);
                                      return Future.delayed(
                                          const Duration(milliseconds: 500));
                                    }
                                  },
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      keyboardDismissBehavior:
                                          ScrollViewKeyboardDismissBehavior
                                              .onDrag,
                                      children: [
                                        selectedFiltersList.isEmpty &&
                                                !searchIsFocused &&
                                                searchController.text.isEmpty
                                            ? GamesCarousel(
                                                bestTickets: bestTickets,
                                                allTickets: allTickets,
                                                isPremium: isPremium,
                                              )
                                            : SizedBox(
                                                width: 150,
                                                height: selectedFiltersList
                                                        .isNotEmpty
                                                    ? 35
                                                    : 0,
                                                child: Scrollbar(
                                                  child: ListView.builder(
                                                    controller:
                                                        ScrollController(),
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount:
                                                        selectedFiltersList
                                                            .length,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                1, 0, 5, 0),
                                                        child: Stack(
                                                          children: [
                                                            TextButton(
                                                              onPressed: () {
                                                                selectedFiltersList
                                                                    .removeAt(
                                                                        index);
                                                                filterTickets();
                                                                SearchTickets(
                                                                    searchController
                                                                        .text);
                                                                setState(() {});
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                tapTargetSize:
                                                                    MaterialTapTargetSize
                                                                        .shrinkWrap,
                                                                foregroundColor:
                                                                    kGreenLightColor,
                                                                backgroundColor:
                                                                    kGreenLightColor,
                                                                elevation: 3,
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
                                                                selectedFiltersList[index]
                                                                            .filterText
                                                                            .length <=
                                                                        3
                                                                    ? selectedFiltersList[
                                                                            index]
                                                                        .filterText
                                                                    : '     ${selectedFiltersList[index].filterText}     ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
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
                                                                  selectedFiltersList
                                                                      .removeAt(
                                                                          index);
                                                                  filterTickets();
                                                                  SearchTickets(
                                                                      searchController
                                                                          .text);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                        //This container is the search bar
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                          decoration: BoxDecoration(
                                            color: kBackgroundColor,
                                            border: Border.all(
                                                color: searchIsFocused
                                                    ? kGreenLightColor
                                                    : Colors.grey[700]!),
                                            borderRadius:
                                                BorderRadius.circular(29.5),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: searchController,
                                                  cursorColor: kGreenLightColor,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  decoration: InputDecoration(
                                                    hintText: "Search",
                                                    icon: Icon(
                                                      Icons.search,
                                                      color: Colors.grey[700],
                                                    ),
                                                    border: InputBorder.none,
                                                    suffixIcon: searchController
                                                            .text.isEmpty
                                                        ? const SizedBox(
                                                            width: 0,
                                                            height: 0,
                                                          )
                                                        : IconButton(
                                                            icon: Icon(
                                                              Icons.close,
                                                              color: Colors
                                                                  .grey[700],
                                                            ),
                                                            onPressed: () {
                                                              searchController
                                                                  .clear();
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
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      searchIsFocused = false;
                                                    });
                                                  },
                                                  onTapOutside: (pointer) {
                                                    setState(() {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      searchIsFocused = false;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Stack(
                                                children: [
                                                  Positioned(
                                                    width: 8,
                                                    height: 8,
                                                    top: 9.0,
                                                    right: 9.0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            kYellowLightColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      final result =
                                                          await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  kBackgroundColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8),
                                                                ),
                                                              ),
                                                              context: context,
                                                              builder: (context) =>
                                                                  GamesSortSheet(
                                                                    selectedSortItemPassed:
                                                                        selectedSortItem,
                                                                    isPremium:
                                                                        isPremium,
                                                                  ));
                                                      if (result != null) {
                                                        selectedSortItem =
                                                            result;
                                                        filterTickets();
                                                        SearchTickets(
                                                            searchController
                                                                .text);
                                                        setState(() {});
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.sort,
                                                      color: kGreenLightColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        allTickets.isEmpty ||
                                                (allTicketsFiltered.isEmpty &&
                                                    selectedFiltersList
                                                        .isNotEmpty)
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Montserrat'),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      selectedFiltersList
                                                              .isNotEmpty
                                                          ? 'Please check your spelling or try removing some filters.'
                                                          : 'Please check your spelling or try different keywords.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Montserrat'),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : GridView(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 200,
                                                        childAspectRatio: .75,
                                                        crossAxisSpacing: 25,
                                                        mainAxisSpacing: 25),
                                                children: selectedFiltersList
                                                        .isEmpty
                                                    ? allTickets
                                                        .map((ticket) =>
                                                            GameCardSmall(
                                                              ticket: ticket,
                                                              isPremium:
                                                                  isPremium,
                                                            ))
                                                        .toList()
                                                    : allTicketsFiltered
                                                        .map((ticket) =>
                                                            GameCardSmall(
                                                                ticket: ticket,
                                                                isPremium:
                                                                    isPremium))
                                                        .toList(),
                                              ),
                                        // GridView.builder(
                                        //         controller: ScrollController(),
                                        //         physics: NeverScrollableScrollPhysics(),
                                        //         shrinkWrap: true,
                                        //         gridDelegate:
                                        //             SliverGridDelegateWithMaxCrossAxisExtent(
                                        //                 maxCrossAxisExtent: 200,
                                        //                 childAspectRatio: 1,
                                        //                 crossAxisSpacing: 10,
                                        //                 mainAxisSpacing: 10),
                                        //         itemCount: selectedFiltersList.isEmpty
                                        //             ? allTickets.length
                                        //             : allTicketsFiltered.length,
                                        //         itemBuilder: (BuildContext ctx, index) {
                                        //           return GameCardSmall(
                                        //             ticket: selectedFiltersList.isEmpty
                                        //                 ? allTickets[index]
                                        //                 : allTicketsFiltered[index],
                                        //           );
                                        //         }),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                _bannerAd != null && !isPremium
                                    ? Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width:
                                              _bannerAd!.size.width.toDouble(),
                                          height:
                                              _bannerAd!.size.height.toDouble(),
                                          child: AdWidget(ad: _bannerAd!),
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
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