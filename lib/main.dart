import 'package:flutter/material.dart';
import 'package:simple_scratch/screens/games_screen.dart';
import 'package:simple_scratch/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Scratch',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the HomePage widget.
        '/': (context) => HomePage(),
        // When navigating to the "/games" route, build the GamesScreen widget.
        '/games': (context) => GamesScreen(),
      },
    );
  }
}