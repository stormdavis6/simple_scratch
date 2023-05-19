import 'package:flutter/material.dart';
import 'package:simple_scratch/widgets/bottom_nav_bar.dart';

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
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      backgroundColor: Color(0xfffffdee),
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  Text(
                    'Simple Scratch',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 48,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}