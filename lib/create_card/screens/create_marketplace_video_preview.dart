import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/create_marketplace_final.dart';
import 'package:holopop/create_card/services/marketplace_service.dart';
import 'package:video_player/video_player.dart';

class CreateMarketplaceVideoPreview extends StatefulWidget {
  const CreateMarketplaceVideoPreview({super.key, required this.videoId});

  final int videoId;

  @override
  State<StatefulWidget> createState() => _CreateMarketplaceVideoPreview();
}

class _CreateMarketplaceVideoPreview extends State<CreateMarketplaceVideoPreview> {
  Timer? t;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    MarketplaceService.getVideo(widget.videoId)
      .then((con) {
        _controller = con;
        return _controller!.initialize();
      })
      .then((_) => setState(() { }));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) => 
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              onPressed: () {
                return;
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateMarketplaceFinal(path: _controller!.dataSource)));
              },
              child: const Text("Continue"),
            )
          ],
        ),
        Row(
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
                          aspectRatio: 3.0/6.0,
                          child: Chewie(
                            controller: ChewieController(
                              videoPlayerController: _controller!,
                              allowFullScreen: true))),
                        Center(
                          child: AnimatedOpacity(
                            opacity: t != null ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  _controller!.value.isPlaying ? _controller!.pause() : _controller!.play(); 
                                });
                              },
                              child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow))))
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
        )
      ]);
}
