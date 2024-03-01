import 'package:holopop/dashboard/models/card.dart';
import 'package:holopop/shared/api/api_service.dart';
import 'package:holopop/shared/config/appsettings.dart';
import 'package:holopop/shared/storage/user_preferences.dart';
import 'package:video_player/video_player.dart';


class CardService {
  static Future<List<HolopopCard>> getCards() {
    return ApiService()
      .get(SimpleGetRequest(resource: "/user/cards"))
      .then((response) { 
        if (response.success == false) {
          return List.empty();
        }
        return response.value!.map((y) => HolopopCard.fromJson(y));
      });
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