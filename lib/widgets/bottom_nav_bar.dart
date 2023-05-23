import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    print('current nav item index :  ${widget.selectedIndex}');
    return Container(
      color: Color(0xfffffdee),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: GNav(
          backgroundColor: Color(0xfffffdee),
          color: Colors.black,
          activeColor: Color(0xff6d9967),
          tabBackgroundColor: Color(0xfffffdee),
          padding: EdgeInsets.all(16),
          gap: 8,
          selectedIndex: widget.selectedIndex,
          onTabChange: (index) {
            print(index);
            setState(() {});
            switch (index) {
              case 0:
                if (widget.selectedIndex != 0) {
                  Navigator.pushNamed(context, '/');
                }
                break;
              case 1:
                if (widget.selectedIndex != 1) {
                  Navigator.pushNamed(context, '/games');
                }
            }
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              active: widget.selectedIndex == 0 ? true : false,
            ),
            GButton(
              icon: Icons.games,
              text: 'Games',
              active: widget.selectedIndex == 1 ? true : false,
            ),
            GButton(
              icon: Icons.analytics,
              text: 'Analysis',
              active: widget.selectedIndex == 2 ? true : false,
            ),
            GButton(
              icon: Icons.person,
              text: 'Login',
              active: widget.selectedIndex == 3 ? true : false,
            ),
          ],
        ),
      ),
    );
  }
}