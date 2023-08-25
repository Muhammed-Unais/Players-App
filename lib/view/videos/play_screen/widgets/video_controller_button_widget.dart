import 'package:flutter/material.dart';
import 'package:players_app/view/videos/play_screen/controller/video_controllers.dart';
import 'package:players_app/view/videos/play_screen/widgets/lock_button.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoControllerButtons extends StatelessWidget {
  const VideoControllerButtons(
      {super.key,
      required this.controllers,
      required this.skipPreviousButton,
      required this.skipNextButton});

  final VideoPlayerController controllers;
  final void Function() skipPreviousButton;
  final void Function() skipNextButton;

  @override
  Widget build(BuildContext context) {

    Widget fullScreenRotate() {
      final vidController = Provider.of<VideoControllers>(context);
      return IconButton(
        onPressed: () {
          vidController.setlandScape();
          vidController.landscapeChange();
        },
        icon: const Icon(
          Icons.screen_rotation,
          color: Colors.white,
          size: 20,
        ),
      );
    }

    final vidController = Provider.of<VideoControllers>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const LockButton(),
            vidController.isShowVideoCntrl
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: skipPreviousButton,
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 12,
                      ),
                      IconButton(
                        onPressed: () async {
                          if (vidController.isPlaying) {
                            vidController.isPauseButton();
                            controllers.pause();
                            await Future.delayed(const Duration(seconds: 5));
                            vidController.videoControllersShow();
                          } else {
                            vidController.isPlayButton();
                            controllers.play();
                          }
                        },
                        icon: Icon(
                          vidController.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 12,
                      ),
                      IconButton(
                        onPressed: skipNextButton,
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            vidController.isShowVideoCntrl 
                ? fullScreenRotate()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
