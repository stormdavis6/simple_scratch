import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:simple_scratch/widgets/game_card_big.dart';
import 'package:simple_scratch/widgets/game_card_carousel.dart';
import '../models/ticket.dart';

class GamesCarousel extends StatefulWidget {
  final List<Ticket> bestTickets;
  const GamesCarousel({Key? key, required this.bestTickets}) : super(key: key);

  @override
  State<GamesCarousel> createState() => _GamesCarouselState();
}

class _GamesCarouselState extends State<GamesCarousel> {
  List<Widget> gameSliders = [];

  @override
  void initState() {
    gameSliders = widget.bestTickets
        .map((ticket) => GameCardBig(ticket: ticket))
        .toList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.bestTickets.forEach((ticket) {
        precacheImage(NetworkImage(ticket.img), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider.builder(
        itemCount: widget.bestTickets.length,
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 1.25,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
        ),
        itemBuilder: (context, index, realIdx) {
          return GameCardCarousel(ticket: widget.bestTickets[index]);
        },
      ),
    );
  }
}