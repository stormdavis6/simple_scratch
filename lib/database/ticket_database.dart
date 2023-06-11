import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/ticket.dart';

class TicketDatabase {
  FirebaseFirestore? _instance;
  List<Ticket> _bestTickets = [];
  List<Ticket> _allTickets = [];
  var now = DateTime.now();
  var formatter = DateFormat('MMddyyyy');

  List<Ticket> getBestTickets() {
    return _bestTickets;
  }

  List<Ticket> getAllTickets() {
    return _allTickets;
  }

  Future<void> getBestTicketsFromFirestore() async {
    _instance = FirebaseFirestore.instance;

    // ${formatter.format(now)}
    CollectionReference bestTickets =
        _instance!.collection('BEST_TICKETS_06082023');

    QuerySnapshot querySnapshot = await bestTickets.get();
    var bestTicketsList = querySnapshot.docs.map((doc) => doc.data());

    bestTicketsList.forEach((element) {
      _bestTickets.add(Ticket.fromJson(element as Map<String, dynamic>));
    });

    _bestTickets.sort((a, b) => a.price.compareTo(b.price));
  }

  Future<void> getAllTicketsFromFirestore() async {
    _instance = FirebaseFirestore.instance;

    // ${formatter.format(now)}
    CollectionReference allTickets =
        _instance!.collection('GAMES_DASHBOARD_06082023');

    QuerySnapshot querySnapshot = await allTickets.get();
    var allTicketsList = querySnapshot.docs.map((doc) => doc.data());

    allTicketsList.forEach((element) {
      _allTickets.add(Ticket.fromJsonNoProb(element as Map<String, dynamic>));
    });

    // _allTickets.sort((a, b) => a.name.compareTo(b.name));
  }
}
