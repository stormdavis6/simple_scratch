import 'package:flutter/material.dart';
import 'package:simple_scratch/widgets/bottom_nav_bar.dart';
import 'package:simple_scratch/widgets/game_card_big.dart';
import 'package:simple_scratch/widgets/game_card_small.dart';
import 'package:simple_scratch/widgets/games_carousel.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xfffffdee),
        bottomNavigationBar: const BottomNavBar(
          selectedIndex: 1,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 48,
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
                                      ..color = Color(0xff696501),
                                    fontFamily: 'Pacifico'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'Scratch-Offs',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Color(0xfff3e674),
                                    fontFamily: 'Pacifico',
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_list_sharp,
                        color: Colors.black,
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
                      SizedBox(
                        height: 300,
                        child: GameCardBig(
                            src:
                                'https://nclottery.com/Content/Images/Instant/nc881_sqr.png'),
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
                          itemCount: gamesList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GameCardSmall(
                              src: gamesList[index],
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