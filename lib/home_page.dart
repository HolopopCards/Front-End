import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holopop/login/login_page.dart';
import 'package:holopop/shared/firebase/firebase_provider.dart';
import 'package:holopop/shared/nav/destination_view.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:holopop/shared/storage/user_preferences.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}


//TODO: FIX THIS TAYLOR IT IS UGLY.
class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseProvider>(context, listen: false).startFirebaseListening();
  }

  static const String LICENSE_TOKEN = "7YYC13U73x7KbJHqQ7BXdDRKfEC8pkAjGbiOTzWJ8kyGqU/C5RBycnrME6qVAvJwsa9EERzANbgcTzDyCUu+UJ8YwbOZIPKfGNEbaK2JgnNGyOk3fX6lsijlw0+ElLvnXhawatxcuYQs1VvLUW8DWB3rl0JBSuZlgc72xMPCqUAgNS05UXnoABrJKAaFRONxXfkudqRggICCL8nj0GbBMVYzFhimRKjgRU/K02qMukj+Cr9jzp3vPo4Q+cEDnmDpz2s+6KsJzf6fjOB248jZtLd38xZGj0QDqcTD7YBFlBAGYW7w7uMxUONt8j2i0LYoExzYb77x6XEZw4PsFD2SZdBdnY3C1F1FeXh7h2Pk8V4sPxow1mW9j0tCmb83MmIMVoNfjgq/kF/2qdSTfRcUMboo85K9GcmGKVA1+IJWd9QJi1BPwAqH3aXYcEdUNfHJPkyp9r18EdnuOZkwikNtiJ7TvV9w68Wm5lUzO/0uhwDwl0tpW2LaayoigbBQxg5WEBdnV9k8y0+4M7vMxzqGcPbUZxRsTBARcfh4OGn1RxXbF8/0sw/rpjrR7Ff+4kpyO+U18lGN8xj0dNv7KD5+x2BAKsx8MoDiWBNxHOxgr4naaEdFo7ZLYcBy3BGcF3lcZ3nlzI0gflyjsc4x4EwOxa6L1NE/6WdVa5Edg+4J6It9E0o0f2sFcUYLLFn6O23FAcTZD+r8ot9RDLMgNPtqNIt3NqGyG8Fi/U1GY/VjM08b4dTpQeXNYDpLjUA4nxZZVphiS7kmiVDeQnnzg8aWczs0358CgTOKpYOxHrkR2LdP1YKGkQSTuMyeEiS6rfNQbYmAOcoJAq2JMwKjL5AupwOLzgZ4tklhJWNwCKdnj0VbVwobJcw1hy+lxtAh5HF/FVC9e1Fep+FBAavBuAx4X0V/57BFhUrpHyDJVFMM2gVce+U6H7lqAz0Kut3qc26cuwkB4cer44I8ouTu3VdrRTQ5x2oVGsiS3+CU3HYQ44k4yOrKyLhYckHfnNK62bIcWQcbBjqwWDBiJG36Ib1hE+Qp9t8/8oEyljJA24ZzqMsuyKXA3xBzTd9WaUsqXI+5OqFT3ODmqw7208qcVVErbtQmpHJajDuZ1xx9VgwinqxZRWOA+Dc2gCka7TV5IC2WMf16dHRURKab+ZnE2F29QxR8Q4H4gxhEtBi81dkq61AX9FNQ+WFE9ruvqicVYMqY+PDdY70W7CMkjYmhu4Gz89ZfacvRswyUxsO3WbArota6ASMcYkFie1NDAqb9lS0XHq10sZ8m1NcrQ4gySADfBP4Vl+eiK7PiC1IdXY3BD0JW+7o4IryhuWz0RHqYzirAqybhaof9jLuGeqBj11/vR/hBF+8DTbSnYsuCQtvBJnLpmk6RC7HwZKTLdJ3l4McT1qV9wjRWg8eg6SCim5hjNZ1wTOzTOaZ0JhVgf3WQHtL4ymeVzcLKHfwuD8+DxF5ubtcMcpupePG6BDO37ea+WPCUN1HnuRHh9L0IEG4F2aWHHRA9k2WIRRWjvcA4zj4wVa/2JcrjuP+4KJpZyJ36vlcGj9Odq5tM5dL4bTGM3xM/hFAr3Hk=";

  static const channelName = 'startActivity/VideoEditorChannel';

  static const methodInitVideoEditor = 'InitBanubaVideoEditor';
  static const methodStartVideoEditor = 'StartBanubaVideoEditor';
  static const methodStartVideoEditorPIP = 'StartBanubaVideoEditorPIP';
  static const methodStartVideoEditorTrimmer = 'StartBanubaVideoEditorTrimmer';
  static const methodDemoPlayExportedVideo = 'PlayExportedVideo';

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

  static const platform = MethodChannel(channelName);

  String _errorMessage = '';

  Future<void> _initVideoEditor() async {
    await platform.invokeMethod(methodInitVideoEditor, LICENSE_TOKEN);
  }

   Future<void> _startVideoEditorDefault() async {
    try {
      await _initVideoEditor();

      final result = await platform.invokeMethod(methodStartVideoEditor);

      _handleExportResult(result);
    } on PlatformException catch (e) {
      _handlePlatformException(e);
    }
  }


  void _handleExportResult(dynamic result) {
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

  var _currentIndex = 0;
  var _showNavBar   = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: 
          FutureBuilder(
           future: UserPreferences().getUserAsync(),
           builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data?.token == null) {
                  return const LoginPage();
                } else {
                  //TODO: THIS IS A HACK
                  if (_showNavBar == false) {
                    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _showNavBar = true));
                  }
                  return IndexedStack(
                    index: _currentIndex,
                    children: allDestinations.map((dest) => DestinationView(destination: dest))
                                             .toList());
                }
            }
          },
        ),
      ),
      bottomNavigationBar: 
        _showNavBar 
          ? BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (i) { setState(() { _currentIndex = i; }); },
            selectedItemColor: HolopopColors.blue,
            unselectedItemColor: HolopopColors.lightgrey,
            showUnselectedLabels: true,
            items: allDestinations.map((dest) =>
              BottomNavigationBarItem(
                label: dest.title,
                icon: Icon(dest.icon)
              )).toList()
            )
          : const SizedBox()
    );
  }
}