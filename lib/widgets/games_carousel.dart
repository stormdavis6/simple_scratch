import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:simple_scratch/widgets/game_card_big.dart';
import 'package:simple_scratch/widgets/game_card_carousel.dart';

final List<String> gamesList = [
  'https://nclottery.com/Content/Images/Instant/nc881_sqr.png',
  'https://nclottery.com/Content/Images/Instant/nc882_sqr.png',
  'https://nclottery.com/Content/Images/Instant/nc871_sqr.png',
  'https://nclottery.com/Content/Images/Instant/nc883_sqr.png',
  'https://nclottery.com/Content/Images/Instant/nc880_sqr.png',
  'https://nclottery.com/Content/Images/Instant/nc884_sqr.png',
  'https://nclottery.com/Content/Images/Instant/nc805_sqr.png',
  'https://nclottery.com/Content/Images/Instant/nc876_sqr.png'
];

class GamesCarousel extends StatefulWidget {
  const GamesCarousel({Key? key}) : super(key: key);

  @override
  State<GamesCarousel> createState() => _GamesCarouselState();
}

class _GamesCarouselState extends State<GamesCarousel> {
  final List<Widget> gameSliders =
      gamesList.map((item) => GameCardBig(src: item)).toList();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gamesList.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider.builder(
        itemCount: gamesList.length,
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 1.25,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
        ),
        itemBuilder: (context, index, realIdx) {
          return GameCardCarousel(src: gamesList[index]);
        },
      ),
    );
  }
}