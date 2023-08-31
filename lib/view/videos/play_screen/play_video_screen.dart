import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:players_app/controllers/video_folder/videos_recently_played_controller.dart';
import 'package:players_app/view/videos/play_screen/controller/video_controllers.dart';
import 'package:players_app/view/videos/play_screen/widgets/video_controlls_widget.dart';
import 'package:players_app/view/videos/play_screen/widgets/videotitle_detail_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreen extends StatefulWidget {
  final List<String> paths;
  final int index;

  const PlayVideoScreen({
    super.key,
    required this.paths,
    required this.index,
  });

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  VideoPlayerController? _controllers;
  late Future<void> _initilizeVideoPlayerFuture;
  int _isPlayingindex = -1;
  bool _isDispose = false;
  int _onControllUpadatTime = 0;

  @override
  void initState() {
    intializeVideo(index: widget.index, paths: widget.paths);
    super.initState();
  }

  void intializeVideo({required int index, required List<String> paths}) {
    addRecentVideo(
      timeStamp: DateTime.now().toUtc().millisecondsSinceEpoch,
      videoPath: paths[index],
    );

    var controllers = VideoPlayerController.file(File(paths[index]));

    final old = _controllers;
    _controllers = controllers;

    if (old != null) {
      old.removeListener(_oncontrollUpdate);
      old.pause();
    }

    _initilizeVideoPlayerFuture = controllers.initialize().then((_) {
      old?.dispose();
      controllers.addListener(_oncontrollUpdate);
      controllers.play();
      controllers.setLooping(true);
      setState(() {});
    });

    _isPlayingindex = index;
  }

  void _oncontrollUpdate() {
    if (_isDispose) return;

    final now = DateTime.now().microsecondsSinceEpoch;

    if (_onControllUpadatTime > now) return;

    _onControllUpadatTime = now + 500;

    final controllers = _controllers;

    if (controllers == null) return;

    if (!controllers.value.isInitialized) return;

    final playing = controllers.value.isPlaying;
    if (mounted) {
      context.read<VideoControllers>().isPlaying = playing;
    }
  }

  void addRecentVideo(
      {required String videoPath, required int timeStamp}) async {
    await context
        .read<VideosRecentlyPlayedController>()
        .addToRecentVideos(videoPath: videoPath, timeStamp: timeStamp);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    _isDispose = true;
    _controllers?.pause();
    _controllers?.dispose();
    _controllers = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.black, systemNavigationBarColor: Colors.black),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  final vidController = context.read<VideoControllers>();
                  if (vidController.isLocked == true) return;
                  vidController.controllsVisibility();
                },
                child: Align(
                  alignment: Alignment.center,
                  child: FutureBuilder(
                    future: _initilizeVideoPlayerFuture,
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _controllers!.value.aspectRatio,
                          child: VideoPlayer(_controllers!),
                        );
                      } else {
                        return const AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 4,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: VideoTitleDetailWidget(
                  videoTitle: widget.paths[_isPlayingindex].split("/").last,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: VideoControllerWidget(
                  controller: _controllers!,
                  skipNextButton: () {
                    final index = _isPlayingindex + 1;
                    if (index <= widget.paths.length - 1) {
                      intializeVideo(index: index, paths: widget.paths);
                    }
                  },
                  skipPreviousButton: () {
                    final index = _isPlayingindex - 1;
                    if (index >= 0 && widget.paths.isNotEmpty) {
                      intializeVideo(
                        index: index,
                        paths: widget.paths,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
