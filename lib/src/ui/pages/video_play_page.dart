import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {

  late YoutubePlayerController controller;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
    controller= YoutubePlayerController(
      initialVideoId: 'HgW4EX_i_hA',
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true

      ),
    );
    controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    controller.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    const play=YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(controller: controller, child: Container(

      child: play,
    ));
  }
}
