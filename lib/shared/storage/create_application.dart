
class CreateApplication {
  final String? type;
  final List<CreateApplicationCard> cards; 

  CreateApplication({
    this.type,
    required this.cards
  });

  @override
  String toString() => "Create App => $type|{${cards.map((c) => "$c").toList()}}";

  Map toJson() => {
    'type': type,
    'cards': cards.map((c) => c.toJson()).toList()
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
  int order;
  final String serialNumber;
  String barcode;

  String? subject;
  String? occasion;
  String? recipient;
  String? message;

  final CreateApplicationCardGift? gift;

  CreateApplicationCard({
    required this.order,
    required this.serialNumber, 
    required this.barcode, 
    this.subject, 
    this.occasion, 
    this.recipient, 
    this.message, 
    this.gift
  });

  @override
  String toString() => "App Card => $order|$serialNumber|$barcode|$subject|$occasion|$recipient|$message|{$gift}";

  Map toJson() => {
    'order': order,
    'serialNumber': serialNumber, 
    'barcode': barcode, 
    'subject': subject, 
    'occasion': occasion, 
    'recipient': recipient, 
    'message': message, 
    'gift': gift?.toJson()
  };

  factory CreateApplicationCard.fromJson(Map<String, dynamic> json) =>
    CreateApplicationCard(
      order: json['order'],
      serialNumber: json['serialNumber'],
      barcode: json['barcode'],
      subject: json['subject'],
      occasion: json['occasion'],
      recipient: json['recipient'],
      message: json['message'],
      gift: json['gift'] == null ? null : CreateApplicationCardGift.fromJson(json['gift']),
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

  @override
  String toString() => "App Gift Card => $name|$description|$sku|$asset";

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