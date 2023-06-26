class User {
  final String uid;
  final String? email;
  final bool isPremium;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;

  User(
      {required this.uid,
      required this.email,
      required this.isPremium,
      required this.creationTime,
      required this.lastSignInTime});
}