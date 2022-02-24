import 'dart:async';

import 'package:derma/src/base/nav.dart';
import 'package:derma/src/base/themes.dart';
import 'package:derma/src/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

// https://www.youtube.com/watch?v=HgW4EX_i_hA

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _showControls = true;
  bool _isEnded=false;
  late Timer _controlsTimer;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
      })
      ..play()
      ..addListener(checkVideo);
    _controlsTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _showControls = false;
      });
    });

    super.initState();
  }

  void checkVideo() {
    if(_controller.value.position == const Duration(seconds: 0, minutes: 0, hours: 0)) {
      debugPrint('video Started');
      return;
    }
    if (_controller.value.position == _controller.value.duration) {
      if (!_isEnded) {
        debugPrint('setState Called');
        Navigator.pop(context);
      }
      _isEnded = true;

    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controlsTimer.cancel();
    _controller.removeListener(checkVideo);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? GestureDetector(
        onTap: () => setState(
              () => _showControls = !_showControls,
        ),
        child: Stack(
          children: [

            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            if (_showControls)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //

                    GestureDetector(
                      onTap: () {
                        _controller.seekTo(
                          Duration(
                            seconds:
                            _controller.value.position.inSeconds - 10,
                          ),
                        );
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: videoControlerColor,
                        ),
                        child: const Icon(
                          Icons.fast_rewind,
                          size: 25,
                          color: Colors.white, // const Color(0xFFEB008B),
                        ),
                      ),
                    ),

                   const SizedBox(
                      width: 8,

                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: videoControlerColor,
                        ),
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 40,
                          color: Colors.white, // const Color(0xFFEB008B),
                        ),
                      ),
                    ),

                    //

                    const SizedBox(
                      width: 8,),
                    GestureDetector(
                      onTap: () {
                        _controller.seekTo(
                          Duration(
                            seconds:
                            _controller.value.position.inSeconds + 10,
                          ),
                        );
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: videoControlerColor,
                        ),
                        child: const Icon(
                          Icons.fast_forward,
                          size: 25,
                          color: Colors.white, // const Color(0xFFEB008B),
                        ),
                      ),
                    ),

                    //
                  ],
                ),
              ),
            if (_showControls)
              Align(
                alignment: Alignment.bottomCenter,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: AppTheme.pinkColor,
                    bufferedColor: Colors.grey,
                    backgroundColor: AppTheme.blueColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 30),
                ),
              ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.close,color: Colors.white,)),
            )
          ],
        ),
      )
          : const Center(
        child: CircularProgressIndicator(
          color: AppTheme.pinkColor,
        ),
      ),
    );
  }


}