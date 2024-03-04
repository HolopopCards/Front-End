import 'package:holopop/dashboard/models/card.dart';
import 'package:holopop/shared/api/api_service.dart';
import 'package:holopop/shared/config/appsettings.dart';
import 'package:holopop/shared/storage/user_preferences.dart';
import 'package:video_player/video_player.dart';

class CardService {
  static Future<List<HolopopCard>> getCards() {
    return ApiService()
      .get(SimpleGetRequest(resource: "/user/cards"), 
        (data) => List.from(data)
                      .map((y) => HolopopCard.fromJson(y))
                      .toList())
      .then((cardsRes) => cardsRes.success == false ? List.empty() : cardsRes.value!);
  }
  
  static Future<VideoPlayerController?> getVideo(String serialNumber) async {
    final token = await UserPreferences().getAccessTokenAsync();
    final controller = VideoPlayerController.networkUrl(
      Uri.parse('${AppSettings().getApiHost()}/user/video?serialNumber=$serialNumber'),
      httpHeaders: {
        'Authorization': 'Bearer $token'
      }
    );
    await controller.initialize();
    return controller;
  }

  static Future<VideoPlayerController?> getOriginalVideo(String serialNumber) async {
    final token = await UserPreferences().getAccessTokenAsync();
    final controller = VideoPlayerController.networkUrl(
      Uri.parse('${AppSettings().getApiHost()}/user/video/original?serialNumber=$serialNumber'),
      httpHeaders: {
        'Authorization': 'Bearer $token'
      }
    );
    await controller.initialize();
    return controller;
  }
}