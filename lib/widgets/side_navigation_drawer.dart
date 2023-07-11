import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_scratch/constants.dart';
import 'package:simple_scratch/screens/account_screen.dart';
import 'package:simple_scratch/screens/auth_screen.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../utils.dart';

class SideNavigationDrawer extends StatelessWidget {
  final bool isPremium;
  const SideNavigationDrawer({super.key, required this.isPremium});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = context.watch<User?>();
    bool isSignedIn = false;
    if (user != null) {
      isSignedIn = true;
    }

    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Drawer(
      backgroundColor: kBackgroundColor,
      width: size.width * .75,
      elevation: 100,
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          SafeArea(
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
          isSignedIn
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : ListTile(
                  title: Text(
                    'Sign In',
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AuthScreen(
                        isLogin: true,
                      );
                    }));
                  },
                ),
          isSignedIn
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : ListTile(
                  title: Text(
                    'Register',
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AuthScreen(
                        isLogin: false,
                      );
                    }));
                  },
                ),
          isSignedIn
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : Divider(
                  color: kBlackLightColor,
                  height: 2,
                  thickness: 1,
                ),
          ListTile(
            title: Text(
              'Scratch-Offs',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name == '/') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, '/');
              }
            },
          ),
          ListTile(
            title: Text(
              'Analysis',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          isSignedIn
              ? ListTile(
                  title: Text(
                    'Account',
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AccountScreen(isPremium: isPremium);
                    }));
                  },
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          Divider(
            color: kBlackLightColor,
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
          isSignedIn
              ? ListTile(
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
                  ),
                  onTap: () async {
                    await authService.signOut();
                    Navigator.pushNamed(context, '/');
                    Utils.showSnackBar(
                        '${user?.email} was signed out', context);
                  },
                )
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }
}