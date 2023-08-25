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
  late VideoPlayerController controllers;
  late Future<void> _initilizeVideoPlayerFuture;
  int isPlayingindex = -1;

  @override
  void initState() {
    intializeVideo(
      index: widget.index,
      paths: widget.paths,
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        addRecentVideo();
      },
    );
    super.initState();
  }

  void intializeVideo({required int index, required List<String> paths}) {
    controllers = VideoPlayerController.file(File(paths[index]));
    _initilizeVideoPlayerFuture = controllers.initialize().then((_) {
      controllers.addListener(_oncontrollUpdate);
      controllers.play();
      if (mounted) {
        setState(() {});
      }
    });

    isPlayingindex = index;
  }

  void _oncontrollUpdate() async {
    if (!controllers.value.isInitialized) return;
    final playing = controllers.value.isPlaying;
    context.read<VideoControllers>().isPlaying = playing;
  }

  void addRecentVideo() async {
    await context.read<VideosRecentlyPlayedController>().addToRecentVideos(
          videoPath: widget.paths[widget.index],
          timeStamp: DateTime.now().toUtc().millisecondsSinceEpoch,
        );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    controllers.removeListener(_oncontrollUpdate);
    controllers.dispose();
    super.dispose();
  }

  int count = 0;
  int pcount = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final vidController = context.read<VideoControllers>();
        if (vidController.isLocked == true) return;
        if (pcount != count) {
          count++;
          await vidController.controllsVisibility();
          pcount++;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: FutureBuilder(
                    future: _initilizeVideoPlayerFuture,
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: controllers.value.aspectRatio,
                          child: VideoPlayer(controllers),
                        );
                      } else {
                        return const AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              value: 4,
                             ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: VideoTitleDetailWidget(
                    videoTitle: widget.paths[isPlayingindex].split("/").last,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: VideoControllerWidget(
                    controller: controllers,
                    skipNextButton: () {
                      final index = isPlayingindex + 1;
                      if (index <= widget.paths.length - 1) {
                        intializeVideo(index: index, paths: widget.paths);
                      }
                    },
                    skipPreviousButton: () {
                      final index = isPlayingindex - 1;
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
      ),
    );
  }
}
