/* Best_Tickets
* calcOdds (String)
* img (String)
* name (String)
* overallOdds (String)
* price (int)
* prob (double)
* topPrize (String)
*/

/* Games_Dashboard
* calcOdds (String)
* calcProb (String)
* claimDeadline (String)
* endDate (String)
* gameNum (String)
* img (String)
* launchDate (String)
* name (String)
* overallOdds (String)
* price (int)
* prizes (array of maps) [key: index, value: odds (String), Remaining (String), Total (String), Value (String)]
* status (String)
* topPrize (String)
*/

class Ticket {
  final String calcOdds;
  final String img;
  final String name;
  final String overallOdds;
  final int price;
  final double? prob;
  final String topPrize;

  Ticket(
      {required this.calcOdds,
      required this.img,
      required this.name,
      required this.overallOdds,
      required this.price,
      required this.prob,
      required this.topPrize});

  factory Ticket.fromJsonBestTicket(Map<String, dynamic> json) {
    return Ticket(
        calcOdds: json['calcOdds'],
        img: json['img'],
        name: json['name'],
        overallOdds: json['overallOdds'],
        price: json['price'],
        prob: json['prob'],
        topPrize: json['topPrize']);
  }

  factory Ticket.fromJsonDashboard(Map<String, dynamic> json) {
    return Ticket(
        calcOdds: json['calcOdds'],
        img: json['img'],
        name: json['name'],
        overallOdds: json['overallOdds'],
        price: json['price'],
        prob: null,
        topPrize: json['topPrize']);
  }
}