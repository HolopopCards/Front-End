import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

class CreateRecordVideo extends StatefulWidget {
  const CreateRecordVideo({super.key});

  @override
  State<StatefulWidget> createState() => _CreateRecordVideo();
}

class _CreateRecordVideo extends State<CreateRecordVideo> {
  @override
  Widget build(BuildContext context) {
    return const Banuba();
  }
}

/// Shits about to get real
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
  static const methodStartVideoEditorPIP = 'StartBanubaVideoEditorPIP';
  static const methodStartVideoEditorTrimmer = 'StartBanubaVideoEditorTrimmer';
  static const methodDemoPlayExportedVideo = 'PlayExportedVideo';
  static const methodInitPhotoEditor = 'InitBanubaPhotoEditor';


  static const errMissingExportResult = 'ERR_MISSING_EXPORT_RESULT';
  static const errStartPIPMissingVideo = 'ERR_START_PIP_MISSING_VIDEO';
  static const errStartTrimmerMissingVideo = 'ERR_START_TRIMMER_MISSING_VIDEO';
  static const errExportPlayMissingVideo = 'ERR_EXPORT_PLAY_MISSING_VIDEO';

  static const errEditorNotInitializedCode = 'ERR_VIDEO_EDITOR_NOT_INITIALIZED';
  static const errEditorNotInitializedMessage =
      'Banuba Video Editor SDK is not initialized: license token is unknown or incorrect.\nPlease check your license token or contact Banuba';
  static const errEditorLicenseRevokedCode = 'ERR_VIDEO_EDITOR_LICENSE_REVOKED';
  static const errEditorLicenseRevokedMessage =
      'License is revoked or expired. Please contact Banuba https://www.banuba.com/faq/kb-tickets/new';

  static const argExportedVideoFile = 'exportedVideoFilePath';
  static const argExportedVideoCoverPreviewPath = 'exportedVideoCoverPreviewPath';
  static const argExportedPhotoFile = 'exportedPhotoFilePath';

  static const platform = MethodChannel(channelName);

  String _errorMessage = '';

  Future<void> _initVideoEditor() async {
    await platform.invokeMethod(methodInitVideoEditor, licenseKey);
  }

  Future<dynamic> startVideoEditor() async {
    Logger("Create Record").info("We start?");
    await platform.invokeMethod(methodInitVideoEditor, licenseKey);
    Logger("Create Record").info("Middle");
    try {
      final result = await platform.invokeMethod(methodStartVideoEditor);
      Logger("Create Record").info("Lookie: $result");
      return result;
    } on Exception catch(e) {
      Logger("Create Record").info("Uh oh: $e");
    }
  }

  Timer? t;
  VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: startVideoEditor(),
      builder: (context, snapshot) {
        Logger('Create Record').info('Step one: ${snapshot.data}. Conn: ${snapshot.connectionState}');
        if (snapshot.hasData) {
          Logger('Create Record').info("Step two: ${snapshot.data[argExportedVideoFile]}");
          final controller = VideoPlayerController.file(File(snapshot.data[argExportedVideoFile]));
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
              return Placeholder();
            },
          );
        }
        return Placeholder();
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           const Padding(
  //             padding: EdgeInsets.all(15.0),
  //             child: Text(
  //               'The sample demonstrates how to run Banuba Video Editor SDK with Flutter',
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontSize: 17.0,
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.all(15.0),
  //             child: Linkify(
  //               text: _errorMessage,
  //               onOpen: (link) async {
  //                 if (await canLaunchUrlString(link.url)) {
  //                   await launchUrlString(link.url);
  //                 } else {
  //                   throw 'Could not launch $link';
  //                 }
  //               },
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontSize: 14.0,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.redAccent,
  //               ),
  //             ),
  //           ),
  //           MaterialButton(
  //             color: Colors.green,
  //             textColor: Colors.white,
  //             disabledColor: Colors.greenAccent,
  //             disabledTextColor: Colors.black,
  //             padding: const EdgeInsets.all(12.0),
  //             splashColor: Colors.blueAccent,
  //             minWidth: 240,
  //             onPressed: () => _startPhotoEditor(),
  //             child: const Text(
  //               'Open Photo Editor',
  //               style: TextStyle(
  //                 fontSize: 14.0,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 24),
  //           MaterialButton(
  //             color: Colors.blue,
  //             textColor: Colors.white,
  //             disabledColor: Colors.grey,
  //             disabledTextColor: Colors.black,
  //             padding: const EdgeInsets.all(12.0),
  //             splashColor: Colors.blueAccent,
  //             minWidth: 240,
  //             onPressed: () => _startVideoEditorDefault(),
  //             child: const Text(
  //               'Open Video Editor - Default',
  //               style: TextStyle(
  //                 fontSize: 14.0,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 24),
  //           MaterialButton(
  //             color: Colors.blue,
  //             textColor: Colors.white,
  //             disabledColor: Colors.grey,
  //             disabledTextColor: Colors.black,
  //             padding: const EdgeInsets.all(16.0),
  //             splashColor: Colors.blueAccent,
  //             minWidth: 240,
  //             onPressed: () => _startVideoEditorPIP(),
  //             child: const Text(
  //               'Open Video Editor - PIP',
  //               style: TextStyle(
  //                 fontSize: 14.0,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 24),
  //           MaterialButton(
  //             color: Colors.blue,
  //             textColor: Colors.white,
  //             disabledColor: Colors.grey,
  //             disabledTextColor: Colors.black,
  //             padding: const EdgeInsets.all(16.0),
  //             splashColor: Colors.blueAccent,
  //             minWidth: 240,
  //             onPressed: () => _startVideoEditorTrimmer(),
  //             child: const Text(
  //               'Open Video Editor - Trimmer',
  //               style: TextStyle(
  //                 fontSize: 14.0,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  // }

  Future<void> _startPhotoEditor() async {
    try {
      dynamic result;
      if (Platform.isAndroid) {
        await _initVideoEditor();

        result = await platform.invokeMethod(methodInitPhotoEditor);
      } else if (Platform.isIOS) {
        result = await platform.invokeMethod(methodInitPhotoEditor, licenseKey);
      }

      _handlePhotoExportResult(result);
    } on PlatformException catch (e) {
      _handlePlatformException(e);
    }
  }

  Future<void> _startVideoEditorDefault() async {
    try {
      await _initVideoEditor();

      final result = await platform.invokeMethod(methodStartVideoEditor);

      _handleVideoExportResult(result);
    } on PlatformException catch (e) {
      _handlePlatformException(e);
    }
  }

  void _handlePhotoExportResult(dynamic result) {
    debugPrint('Export result = $result');

    // You can use any kind of export result passed from platform.
    // Map is used for this sample to demonstrate playing exported video file.
    if (result is Map) {
      final exportedPhotoFilePath = result[argExportedPhotoFile];
      debugPrint('Exported photo file path = $exportedPhotoFilePath');
    }
  }

  void _handleVideoExportResult(dynamic result) {
    debugPrint('Export result = $result');

    // You can use any kind of export result passed from platform.
    // Map is used for this sample to demonstrate playing exported video file.
    if (result is Map) {
      final exportedVideoFilePath = result[argExportedVideoFile];

      // Use video cover preview to meet your requirements
      final exportedVideoCoverPreviewPath = result[argExportedVideoCoverPreviewPath];

      _showConfirmation(context, "Play exported video file?", () {
        platform.invokeMethod(methodDemoPlayExportedVideo, exportedVideoFilePath);
      });
    }
  }

  Future<void> _startVideoEditorPIP() async {
    try {
      await _initVideoEditor();

      // Use your implementation to provide correct video file path to start Video Editor SDK in PIP mode
      final ImagePicker _picker = ImagePicker();
      final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);

      if (file == null) {
        debugPrint('Cannot open video editor with PIP - video was not selected!');
      } else {
        debugPrint('Open video editor in pip with video = ${file.path}');
        final result = await platform.invokeMethod(methodStartVideoEditorPIP, file.path);

        _handleVideoExportResult(result);
      }
    } on PlatformException catch (e) {
      _handlePlatformException(e);
    }
  }

  Future<void> _startVideoEditorTrimmer() async {
    try {
      await _initVideoEditor();

      // Use your implementation to provide correct video file path to start Video Editor SDK in Trimmer mode
      final ImagePicker _picker = ImagePicker();
      final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);

      if (file == null) {
        debugPrint('Cannot open video editor with Trimmer - video was not selected!');
      } else {
        debugPrint('Open video editor in trimmer with video = ${file.path}');
        final result = await platform.invokeMethod(methodStartVideoEditorTrimmer, file.path);

        _handleVideoExportResult(result);
      }
    } on PlatformException catch (e) {
      _handlePlatformException(e);
    }
  }


  // Handle exceptions thrown on Android, iOS platform while opening Video Editor SDK
  void _handlePlatformException(PlatformException exception) {
    debugPrint("Error: '${exception.message}'.");

    String errorMessage = '';
    switch (exception.code) {
      case errEditorLicenseRevokedCode:
        errorMessage = errEditorLicenseRevokedMessage;
        break;
      case errEditorNotInitializedCode:
        errorMessage = errEditorNotInitializedMessage;
        break;
      default:
        errorMessage = 'unknown error';
    }

    _errorMessage = errorMessage;
    setState(() {});
  }

  void _showConfirmation(
      BuildContext context, String message, VoidCallback block) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          MaterialButton(
            color: Colors.red,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: const EdgeInsets.all(12.0),
            splashColor: Colors.redAccent,
            onPressed: () => {Navigator.pop(context)},
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.green,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: const EdgeInsets.all(12.0),
            splashColor: Colors.greenAccent,
            onPressed: () {
              Navigator.pop(context);
              block.call();
            },
            child: const Text(
              'Ok',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}