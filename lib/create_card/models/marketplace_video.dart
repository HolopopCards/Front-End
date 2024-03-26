class MarketplaceVideo {
  final int id;
  final String title;
  final double price;
  final String category;
  final String image;

  MarketplaceVideo({
    required this.id, 
    required this.title, 
    required this.price, 
    required this.category,
    required this.image,
  });

  factory MarketplaceVideo.fromJson(Map<String, dynamic> data) => 
    MarketplaceVideo(
      id: data['id'], 
      title: data['title'], 
      price: data['price'], 
      category: data['marketplaceCategory'],
      image: data['image'],
    );
}