import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfffffdee),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Color(0xfffffdee),
          color: Colors.black,
          activeColor: Color(0xff6d9967),
          tabBackgroundColor: Color(0xfffffdee),
          padding: EdgeInsets.all(16),
          gap: 8,
          onTabChange: (index) {
            print(index);
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.games,
              text: 'Games',
            ),
            GButton(
              icon: Icons.analytics,
              text: 'Analysis',
            ),
            GButton(
              icon: Icons.person,
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}