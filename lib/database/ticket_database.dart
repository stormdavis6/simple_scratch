import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../models/ticket.dart';

class TicketDatabase {
  FirebaseFirestore? _instance;

  List<Ticket> _bestTickets = [];
  List<Ticket> _allTickets = [];

  DateFormat formatter = DateFormat('MMddyyyy');

  DateTime getESTTime() {
    tz.initializeTimeZones();
    final DateTime now = DateTime.now();
    final easternTime = tz.getLocation('America/New_York');
    return tz.TZDateTime.from(now, easternTime);
  }

  List<Ticket> getBestTickets() {
    return _bestTickets;
  }

  List<Ticket> getAllTickets() {
    return _allTickets;
  }

  Future<void> getBestTicketsFromFirestore() async {
    _instance = FirebaseFirestore.instance;

    CollectionReference bestTickets =
        _instance!.collection('BEST_TICKETS_${formatter.format(getESTTime())}');

    QuerySnapshot querySnapshot = await bestTickets.get();
    var bestTicketsList = querySnapshot.docs.map((doc) => doc.data());

    bestTicketsList.forEach((element) {
      _bestTickets
          .add(Ticket.fromJsonBestTicket(element as Map<String, dynamic>));
    });

    _bestTickets.sort((a, b) => a.price.compareTo(b.price));
  }

  Future<void> getAllTicketsFromFirestore() async {
    _instance = FirebaseFirestore.instance;

    // ${formatter.format(now)}
    CollectionReference allTickets = _instance!
        .collection('GAMES_DASHBOARD_${formatter.format(getESTTime())}');

    QuerySnapshot querySnapshot = await allTickets.get();
    var allTicketsList = querySnapshot.docs.map((doc) => doc.data());

    allTicketsList.forEach((element) {
      _allTickets
          .add(Ticket.fromJsonDashboard(element as Map<String, dynamic>));
    });

    _allTickets.sort((a, b) => b.price.compareTo(a.price));
  }
}