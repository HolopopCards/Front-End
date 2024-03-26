import 'package:holopop/create_card/models/marketplace_audio.dart';
import 'package:holopop/create_card/models/marketplace_video.dart';
import 'package:holopop/create_card/models/marketplace_video_thumbnail.dart';
import 'package:holopop/shared/api/api_service.dart';
import 'package:holopop/shared/config/appsettings.dart';
import 'package:holopop/shared/storage/user_preferences.dart';
import 'package:video_player/video_player.dart';

class MarketplaceService {
  static Future<List<MarketplaceVideo>> getVideos() =>
    ApiService()
      .get(SimpleGetRequest(resource: "/marketplace/videos"),
        (data) => List.from(data)
                      .map((y) => MarketplaceVideo.fromJson(y))
                      .toList())
      .then((res) => res.success ? res.value! : List.empty());

  static Future<List<MarketplaceVideoThumbnail>> getThumbnails(List<int> ids) =>
    ApiService()
      .get(SimpleGetRequest(
        resource: "/marketplace/thumbnails?$ids={ids[0]}${ids.fold("", (previousValue, element) => "$previousValue&ids=$element")}"),
        (data) => List.from(data)
                      .map((y) => MarketplaceVideoThumbnail.fromJson(y))
                      .toList())
      .then((res) => res.success ? res.value! : List.empty());

  static Future<VideoPlayerController?> getVideo(int id) async {
    final token = await UserPreferences().getAccessTokenAsync();
    final controller = VideoPlayerController.networkUrl(
      Uri.parse("${AppSettings().getApiHost()}/marketplace/video?videoid=$id"),
      httpHeaders: {'Authorization': "Bearer $token" });
    return controller;
  }

  static Future<List<MarketplaceAudioCategory>> getAudios() =>
    ApiService()
      .get(SimpleGetRequest(resource: "/marketplace/audios"),
        (data) => List.from(data)
                      .map((y) => MarketplaceAudioCategory.fromJson(y))
                      .toList())
      .then((res) => res.success ? res.value! : List.empty());
}
