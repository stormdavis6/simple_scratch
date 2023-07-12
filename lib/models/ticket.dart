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
* calcOdds (String) ✔
* calcProb (String)
* claimDeadline (String)
* endDate (String)
* gameNum (String)
* img (String) ✔
* launchDate (String)
* name (String) ✔
* overallOdds (String) ✔
* price (int) ✔
* prizes (array of maps) [key: index, value: odds (String), Remaining (String), Total (String), Value (String)]
* status (String)
* topPrize (String) ✔
*/

class Ticket {
  final String calcOdds;
  final String img;
  final String name;
  final String overallOdds;
  final int price;
  final String topPrize;
  final double? prob;
  final String? calcProb;
  final String? claimDeadline;
  final String? endDate;
  final String? gameNum;
  final String? launchDate;
  final String? status;
  final String? date;
  final String? height;
  final String? width;
  final String? overallEv;
  final String? calculatedEv;
  final dynamic prizes;

  Ticket(
      {required this.calcOdds,
      required this.img,
      required this.name,
      required this.overallOdds,
      required this.price,
      required this.topPrize,
      required this.prob,
      required this.calcProb,
      required this.claimDeadline,
      required this.endDate,
      required this.gameNum,
      required this.launchDate,
      required this.status,
      required this.date,
      required this.height,
      required this.width,
      required this.overallEv,
      required this.calculatedEv,
      required this.prizes});

  factory Ticket.fromJsonBestTicket(Map<String, dynamic> json) {
    return Ticket(
        calcOdds: json['calcOdds'],
        img: json['img'],
        name: json['name'],
        overallOdds: json['overallOdds'],
        price: json['price'],
        topPrize: json['topPrize'],
        prob: json['prob'],
        calcProb: null,
        claimDeadline: null,
        endDate: null,
        gameNum: null,
        launchDate: null,
        status: null,
        date: null,
        height: null,
        width: null,
        overallEv: json['EV'],
        calculatedEv: json['adjustedEV'],
        prizes: null);
  }

  factory Ticket.fromJsonDashboard(Map<String, dynamic> json) {
    return Ticket(
        calcOdds: json['calcOdds'],
        img: json['img'],
        name: json['name'],
        overallOdds: json['overallOdds'],
        price: json['price'],
        topPrize: json['topPrize'],
        prob: null,
        calcProb: json['calcProb'],
        claimDeadline: json['claimDeadline'],
        endDate: json['endDate'],
        gameNum: json['gameNum'],
        launchDate: json['launchDate'],
        status: json['status'],
        date: json['date'],
        height: json['height'],
        width: json['width'],
        overallEv: json['EV'],
        calculatedEv: json['adjustedEV'],
        prizes: json['prizes']);
  }
}