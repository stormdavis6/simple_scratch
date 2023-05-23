import 'package:flutter/material.dart';
import 'package:simple_scratch/widgets/bottom_nav_bar.dart';

import '../widgets/games_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        bottomNavigationBar: BottomNavBar(
          selectedIndex: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                            'Simple Scratch',
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
                          'Simple Scratch',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Color(0xfff3e674),
                                    fontFamily: 'Pacifico',
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 48,
                    ),
                  ],
                ),
                SizedBox(height: 345, child: GamesCarousel()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}