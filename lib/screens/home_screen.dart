// import 'package:flutter/material.dart';
// import 'package:simple_scratch/constants.dart';
// import 'package:simple_scratch/widgets/bottom_nav_bar.dart';
// import 'package:simple_scratch/widgets/info_card.dart';
//
// import '../widgets/games_carousel.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context)
//         .size; //this gonna give us total height and with of our device
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: kBackgroundColor,
//         bottomNavigationBar: BottomNavBar(
//           selectedIndex: 0,
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.menu,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Stack(
//                       children: [
//                         Positioned.directional(
//                           textDirection: TextDirection.rtl,
//                           child: Text(
//                             'Simple Scratch',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleLarge
//                                 ?.copyWith(
//                                     foreground: Paint()
//                                       ..style = PaintingStyle.stroke
//                                       ..strokeWidth = 2
//                                       ..color = kGreenOliveColor,
//                                     fontFamily: 'Pacifico'),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Text(
//                           'Simple Scratch',
//                           style:
//                               Theme.of(context).textTheme.titleLarge?.copyWith(
//                                     color: kYellowLightColor,
//                                     fontFamily: 'Pacifico',
//                                   ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 48,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 40,
//                     ),
//                     Text(
//                       'Top Games',
//                       style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           foreground: Paint()
//                             ..style = PaintingStyle.stroke
//                             ..strokeWidth = 2
//                             ..color = Colors.black87,
//                           fontFamily: 'Montserrat'),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//                 Flexible(
//                   child: ListView(
//                     physics: ScrollPhysics(),
//                     children: [
//                       SizedBox(
//                         height: 345,
//                         child: GamesCarousel(),
//                       ),
//                       InfoCard(
//                         title: 'Simplify Your Odds',
//                         titleColor: kGreenLightColor,
//                         body:
//                             'Make the most informed decision when it comes to your scratch off games',
//                         btnText: 'Learn More',
//                         btnTextColor: Colors.white,
//                         btnColor: kGreenLightColor,
//                         backgroundColor: kBackgroundColor,
//                         borderColor: kGreenDarkColor,
//                       ),
//                       InfoCard(
//                         title: 'Frequently Asked Questions',
//                         titleColor: kYellowLightColor,
//                         body:
//                             'Get answers to common questions with our FAQs or contact us for help',
//                         btnText: 'Learn More',
//                         btnTextColor: Colors.white,
//                         btnColor: kYellowLightColor,
//                         backgroundColor: kBackgroundColor,
//                         borderColor: kGreenOliveColor,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }