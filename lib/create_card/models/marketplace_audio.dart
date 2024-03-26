class MarketplaceAudioCategory {
  final int id;
  final String title;
  final String image;
  final List<MarketplaceAudio> audios;

  MarketplaceAudioCategory({
    required this.id,
    required this.title,
    required this.image, 
    required this.audios
  });

  factory MarketplaceAudioCategory.fromJson(Map<String, dynamic> data) =>
    MarketplaceAudioCategory(
      id: data['id'],
      title: data['title'],
      image: data['image'],
      audios: List.from(data['audios'])
                  .map((a) => MarketplaceAudio.fromJson(a))
                  .toList(),
      );
}


class MarketplaceAudio {
  final int id;
  final String title;

  MarketplaceAudio({
    required this.id, 
    required this.title, 
  });

  factory MarketplaceAudio.fromJson(Map<String, dynamic> data) => 
    MarketplaceAudio(
      id: data['id'], 
      title: data['title'], 
    );
}