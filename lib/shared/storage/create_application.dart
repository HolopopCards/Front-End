
class CreateApplication {
  final String? type;
  final List<CreateApplicationCard> cards; 

  CreateApplication({
    this.type,
    required this.cards
  });

  Map toJson() => {
    'type': type,
    'cards': cards.map((c) => c.toJson())
  };

  factory CreateApplication.fromJson(Map<String, dynamic> json) => 
    CreateApplication(
      type: json['type'],
      cards: List.from(json['cards'])
                 .map((c) => CreateApplicationCard.fromJson(c))
                 .toList()
    );
}


class CreateApplicationCard {
  final int number;
  final String barcode;

  final String? subject;
  final String? occasion;
  final String? recipient;
  final String? message;

  final CreateApplicationCardGift? gift;

  CreateApplicationCard({
    required this.number, 
    required this.barcode, 
    this.subject, 
    this.occasion, 
    this.recipient, 
    this.message, 
    this.gift
  });

  Map toJson() => {
    'number': number, 
    'barcode': barcode, 
    'subject': subject, 
    'occasion': occasion, 
    'recipient': recipient, 
    'message': message, 
    'gift': gift?.toJson()
  };

  factory CreateApplicationCard.fromJson(Map<String, dynamic> json) =>
    CreateApplicationCard(
      number: json['number'],
      barcode: json['barcode'],
      subject: json['subject'],
      occasion: json['occasion'],
      recipient: json['recipient'],
      message: json['message'],
      gift: CreateApplicationCardGift.fromJson(json['gift']),
    );
}


class CreateApplicationCardGift {
  final String name;
  final String description;
  final String sku;
  final String asset;

  CreateApplicationCardGift({
    required this.name,
    required this.description, 
    required this.sku, 
    required this.asset
  });

  Map toJson() => {
    'name': name,
    'description': description, 
    'sku': sku, 
    'asset': asset
  };

  factory CreateApplicationCardGift.fromJson(Map<String, dynamic> json) =>
    CreateApplicationCardGift(
      name: json['name'],
      description: json['description'], 
      sku: json['sku'], 
      asset: json['asset']
    );
}