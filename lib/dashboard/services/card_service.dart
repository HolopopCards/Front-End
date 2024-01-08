import 'dart:convert';
import 'package:holopop/dashboard/models/card.dart';
import 'package:holopop/shared/config/appsettings.dart';
import 'package:holopop/shared/storage/user_preferences.dart';
import 'package:http/http.dart';
import 'package:video_player/video_player.dart';


class CardService {
  static Future<List<HolopopCard>> getCards() async {
    final token = await UserPreferences().getTokenAsync();
    final response = await get(
      Uri.parse('${AppSettings().getApiHost()}/user/cards'),
      headers: { 
        'Content-Type': 'application/json', 
        'Authorization': 'Bearer $token'
      }
    );

    return List<HolopopCard>.from(
      json.decode(response.body)
          .map((y) => HolopopCard.fromJson(y))
    );
  }

  static Future<VideoPlayerController> getOriginalVideo(String serialNumber) async {
    final token = await UserPreferences().getTokenAsync();
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