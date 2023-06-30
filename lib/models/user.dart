class User {
  final String uid;
  final String? email;
  bool isPremium;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;
  final String providerId;

  User(
      {required this.uid,
      required this.email,
      required this.isPremium,
      required this.creationTime,
      required this.lastSignInTime,
      required this.providerId});
}