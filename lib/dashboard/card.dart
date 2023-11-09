class HolopopCard {
  final String from;
  final String subject;
  final DateTime sent;
  final bool fromMe;
  final String occasion;
  final String body;

  const HolopopCard({
    required this.from,
    required this.subject,
    required this.sent,
    required this.fromMe,
    required this.occasion,
    required this.body,
  });
}