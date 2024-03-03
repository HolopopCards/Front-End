class User {
  final String username;
  final String token;
  final String refreshToken;

  User({
    required this.username,
    required this.token,
    required this.refreshToken});

  @override
  String toString() =>
    "User Model => $username|$token|$refreshToken";
}