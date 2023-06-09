import 'package:flutter/cupertino.dart';

class Ticket {
  int id = UniqueKey().hashCode;
  String calcOdds;
  String img;
  String name;
  String overallOdds;
  int price;
  double prob;
  String topPrize;

  Ticket(
      {required this.calcOdds,
      required this.img,
      required this.name,
      required this.overallOdds,
      required this.price,
      required this.prob,
      required this.topPrize});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        calcOdds: json['calcOdds'],
        img: json['img'],
        name: json['name'],
        overallOdds: json['overallOdds'],
        price: json['price'],
        prob: json['prob'],
        topPrize: json['topPrize']);
  }
}