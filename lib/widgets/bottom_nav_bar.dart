import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:simple_scratch/screens/auth_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    bool isSignedIn = false;
    if (user != null) {
      isSignedIn = true;
    }

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
            setState(() {});
            switch (index) {
              case 0:
                if (widget.selectedIndex != 0) {
                  Navigator.pushNamed(context, '/');
                }
                break;
              case 2:
                if (!isSignedIn) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AuthScreen(
                      isLogin: true,
                    );
                  }));
                }
                break;
            }
          },
          tabs: [
            GButton(
              icon: Icons.games,
              text: 'Games',
              active: widget.selectedIndex == 0 ? true : false,
            ),
            GButton(
              icon: Icons.analytics,
              text: 'Analysis',
              active: widget.selectedIndex == 1 ? true : false,
            ),
            GButton(
              icon: Icons.person,
              text: isSignedIn ? 'Account' : 'Sign In',
              active: widget.selectedIndex == 2 ? true : false,
            ),
          ],
        ),
      ),
    );
  }
}