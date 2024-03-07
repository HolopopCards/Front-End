import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:holopop/create_card/services/create_service.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:logging/logging.dart';

class CreateUpload extends StatelessWidget {
  const CreateUpload({super.key});

  @override
  Widget build(BuildContext context) {
    Logger('create:upload').info("Uploading file for card...");
    FilePicker.platform
      .pickFiles(
        type: FileType.video,
        allowedExtensions: [ 'mp4' ])
      .then((result) {
        if (result != null) {
          Logger('create:upload').info("Uploading file: ${result.files.single.path}");
          final video = File(result.files.single.path!);
          CreateApplicationStorage()
            .updateAppAsync((a) => a.video = video)
            .then((_) => CreateApplicationStorage().getAppAsync())
            .then((app) => CreateService.finishApplication(app.value!))
            .then((_) => Navigator.pushNamed(context, "/create/final"));
        } else {
          Navigator.pushNamed(context, "/create/media-type");
        }
      });
    return const Scaffold(
      body: CircularProgressIndicator());
  }
}