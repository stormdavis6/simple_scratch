import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';

class SideNavigationDrawer extends StatelessWidget {
  const SideNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Drawer(
      backgroundColor: kBackgroundColor,
      width: size.width * .75,
      elevation: 100,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 110,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(color: kBackgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Sign In',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Register',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Sign Out',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
            ),
            onTap: () {},
          ),
          Divider(
            color: Color(0xff363636),
            height: 2,
            thickness: 1,
          ),
          ListTile(
            title: Text(
              'Scratch-Offs',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Analysis',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Account',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          Divider(
            color: Color(0xff363636),
            height: 2,
            thickness: 1,
          ),
          ListTile(
            title: Text(
              'Premium',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'About',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Help & FAQ',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Feedback',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}