
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:holopop/create_card/services/create_service.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:logging/logging.dart';

class Banuba extends StatefulWidget {
  const Banuba({super.key});

  @override
  State<StatefulWidget> createState() => _Banuba();
}

class _Banuba extends State<Banuba> {
  final String licenseKey = GlobalConfiguration().get("banubaLicenseKey");

  static const channelName = 'banubaSdkChannel';
  static const methodInitVideoEditor = 'InitBanubaVideoEditor';
  static const methodStartVideoEditor = 'StartBanubaVideoEditor';
  static const argExportedVideoFilePath = 'exportedVideoFilePath';

  static const platform = MethodChannel(channelName);

  Future<dynamic> startVideoEditor() async {
    Logger('banuba').info("Initializing video editor...");
    await platform.invokeMethod(methodInitVideoEditor, licenseKey);
    try {
      Logger('banuba').info("Starting video editor...");
      return await platform.invokeMethod(methodStartVideoEditor);
    } on PlatformException catch(e) {
      Logger('banuba').severe("ERROR: ${e.message}...");
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: startVideoEditor(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Logger('Banuba').info("Video editor done.");
          final video = File(snapshot.data[argExportedVideoFilePath]);
          CreateApplicationStorage()
            .updateAppAsync((a) => a.video = video)
            .then((_) => CreateApplicationStorage().getAppAsync())
            .then((app) => CreateService.finishApplication(app.value!))
            .then((_) => Navigator.pushNamed(context, "/create/final"));
        }
        return const CircularProgressIndicator();
      },
    );
  }
}