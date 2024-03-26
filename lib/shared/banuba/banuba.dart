
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:holopop/create_card/services/create_service.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';

enum VideoEditorMode { record, trim }

class Banuba extends StatefulWidget {
  const Banuba({
    super.key, 
    required this.mode, 
    this.path
  });

  final VideoEditorMode mode;
  final String? path;

  @override
  State<StatefulWidget> createState() => _Banuba();
}

class _Banuba extends State<Banuba> {
  final String licenseKey = GlobalConfiguration().get("banubaLicenseKey");

  static const channelName = 'banubaSdkChannel';
  static const methodInitVideoEditor = 'InitBanubaVideoEditor';
  static const methodStartVideoEditor = 'StartBanubaVideoEditor';
  static const methodStartVideoTrimmer = 'StartBanubaVideoEditorTrimmer';
  static const argExportedVideoFilePath = 'exportedVideoFilePath';

  static const platform = MethodChannel(channelName);

  Future<dynamic> initVideoEditor() async {
    await platform.invokeMethod(methodInitVideoEditor, licenseKey);
  }

  Future<dynamic> startVideoEditor() async {
    Logger('banuba:record').info("Initializing video editor...");
    await initVideoEditor();
    try {
      Logger('banuba:record').info("Starting video editor...");
      return await platform.invokeMethod(methodStartVideoEditor);
    } on PlatformException catch(e) {
      Logger('banuba:record').severe("ERROR: ${e.message}...");
    }
  }

  Future<dynamic> startVideoTrimmer() async {
    Logger('banuba:trimmer').info("Initializing video trimmer...");
    await initVideoEditor();

    var path = widget.path;
    if (path == null) {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickVideo(source: ImageSource.gallery);
      path = file!.path;
    }

    try {
      Logger('banuba:trimmer').info("Starting video trimmer...");
      return await platform.invokeMethod(methodStartVideoTrimmer, path);
    } on PlatformException catch(e) {
      Logger('banuba:trimmer').severe("ERROR: ${e.message}...");
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> func;
    switch (widget.mode) {
      case VideoEditorMode.trim: func = startVideoTrimmer(); break;
      default:                   func = startVideoEditor(); break;
    }

    return FutureBuilder(
      future: func,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Logger('banuba').info("Video editor done.");
          final video = File(snapshot.data[argExportedVideoFilePath]);
          CreateApplicationStorage()
            .updateAppAsync((a) => a.video = video)
            .then((_) => CreateApplicationStorage().getAppAsync())
            .then((app) => CreateService.finishApplication(app.value!))
            .then((res) => res.success ? Navigator.pushNamed(context, "/create/final") : Navigator.pushNamed(context, "/create/error"));
        }
        return const CircularProgressIndicator();
      },
    );
  }
}