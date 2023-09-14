import 'package:flutter/material.dart';
import 'package:domedia/view/videos/play_screen/controller/video_controllers.dart';
import 'package:domedia/view/videos/play_screen/widgets/video_controller_button_widget.dart';
import 'package:domedia/view/videos/play_screen/widgets/video_duration_controller.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoControllerWidget extends StatelessWidget {
  const VideoControllerWidget(
      {super.key,
      required this.controller,
      required this.skipPreviousButton,
      required this.skipNextButton});

  final VideoPlayerController controller;
  final void Function() skipPreviousButton;
  final void Function() skipNextButton;

  @override
  Widget build(BuildContext context) {
  
    return Consumer<VideoControllers>(
      builder: (context,videoControllerProvider,_) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          color: videoControllerProvider.isShowVideoCntrl 
              ? Colors.transparent.withAlpha(150)
              : Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              videoControllerProvider.isShowVideoCntrl
                  ? VideoDurationController(
                      context: context, controller: controller)
                  : const SizedBox(),
              const SizedBox(
                height: 12,
              ),
              VideoControllerButtons(
                  controllers: controller,
                  skipNextButton: skipNextButton,
                  skipPreviousButton: skipPreviousButton),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      }
    );
  }
}
