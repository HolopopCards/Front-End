class MarketplaceVideoThumbnail {
  final int id;
  final String image;

  MarketplaceVideoThumbnail({required this.id, required this.image});

  factory MarketplaceVideoThumbnail.fromJson(Map<String, dynamic> data) =>
    MarketplaceVideoThumbnail(
      id: data['id'],
      image: data['image']);
}
