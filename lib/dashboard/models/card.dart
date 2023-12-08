class HolopopCard {
  final String serialNumber;
  final String to;
  final String? toUser;
  final String from;
  final String? fromUser;
  final String subject;
  final DateTime sent;
  final bool fromMe;
  final String occasion;
  final String body;

  const HolopopCard({
    required this.serialNumber,
    required this.to,
    required this.toUser,
    required this.from,
    required this.fromUser,
    required this.subject,
    required this.sent,
    required this.fromMe,
    required this.occasion,
    required this.body,
  });

  factory HolopopCard.fromJson(dynamic data) {
    return HolopopCard(
      serialNumber: data['serialNumber'],
      to: data['to'],
      toUser: data['toUser'],
      from: data['from'],
      fromUser: data['fromUser'],
      subject: data['subject'],
      sent: DateTime.parse(data['sent']),
      fromMe: data['fromMe'],
      occasion: data['occasion'],
      body: data['body'],
    );
  }
}