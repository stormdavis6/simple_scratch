class User {
  final String uid;
  final String? email; // 1 for ticketPrice, 2 for TopPrize
  final bool isPremium;

  User({required this.uid, required this.email, required this.isPremium});
}