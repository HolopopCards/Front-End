import 'package:holopop/shared/api/api_service.dart';
import 'package:holopop/shared/monads/result.dart';
import 'package:holopop/shared/storage/create_application.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class CreateService {

  static Future<Result> finishApplication(CreateApplication app) async {
    Logger('create service').fine("Finishing application...");
    final video = app.video;
    if (video == null) {
      return Result.fromFailure("No video in the application");
    }

    final files = [ await http.MultipartFile.fromPath('Video', video.path) ];

    final vidUploadResult = await ApiService()
      .postFile(
        FilePostRequest(
          resource: "/user/video",
          files: files,
          contentType: 'video/mp4'),
        (data) => data["id"] as int);

    if (vidUploadResult.success == false) {
      Logger('create service').severe("Vid upload failed: ${vidUploadResult.error}");
      return Result.fromFailure(vidUploadResult.error!);
    }
    final videoId = vidUploadResult.value!;

    final postCardsResult = await ApiService()  
      .post(
        SimplePostRequest(
          resource: "/user/cards",
          body: {
            "videoid": videoId,
            "cards": app.cards
                        .map((c) => {
                          "serialNumber": c.serialNumber,
                          "to": c.recipient,
                          "occasion": c.occasion,
                          "body": c.message,
                          "subject": c.subject})
                        .toList()}),
        (_) => null);

    if (postCardsResult.success == false) {
      return Result.fromFailure(postCardsResult.error!);
    }
    return Result.fromSuccess(null);
  }
}