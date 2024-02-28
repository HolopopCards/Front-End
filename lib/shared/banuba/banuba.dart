
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';

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
    Logger("Banuba").info("Initializing video editor...");
    await platform.invokeMethod(methodInitVideoEditor, licenseKey);
    try {
      Logger("Banuba").info("Starting video editor...");
      return await platform.invokeMethod(methodStartVideoEditor);
    } on PlatformException catch(e) {
      Logger("Banuba").severe("ERROR: ${e.message}...");
    }
  }

  Timer? t;
  VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: startVideoEditor(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Logger("Banuba").info("Video editor done.");
          final controller = VideoPlayerController.file(File(snapshot.data[argExportedVideoFilePath]));
          _controller = controller;
          return FutureBuilder(
            future: _controller!.initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Logger('Create Record').info("Step three: ${_controller?.value.isInitialized}");
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _controller?.value.isInitialized == true
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                t?.cancel();
                                t = Timer(const Duration(seconds: 2), () => setState(() => t = null));
                              });
                            },
                            child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 4.0/3.0,
                                    child: VideoPlayer(_controller!),
                                  ),
                                  Center(
                                    child: AnimatedOpacity(
                                      opacity: t != null ? 1 : 0,
                                      duration: const Duration(milliseconds: 200),
                                      child: FloatingActionButton(
                                        onPressed: () { setState(() { _controller!.value.isPlaying ? _controller!.pause() : _controller!.play(); }); },
                                        child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow)
                                      )
                                    )
                                  )
                              ],
                            )
                        )
                        : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: const FractionallySizedBox(
                            heightFactor: 0.3,
                            widthFactor: 0.3,
                            child: CircularProgressIndicator()
                          ),
                        )
                    ),
                  ],
                );
              }
              return const Placeholder();
            },
          );
        }
        return const Placeholder();
      },
    );
  }
}