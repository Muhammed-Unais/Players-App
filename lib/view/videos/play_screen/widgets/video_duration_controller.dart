import 'package:flutter/material.dart';
import 'package:players_app/view/videos/play_screen/controller/video_controllers.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoDurationController extends StatelessWidget {
  const VideoDurationController({
    super.key,
    required this.context,
    required this.controller,
  });

  final BuildContext context;
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final vidController = Provider.of<VideoControllers>(context);
    return Container(
      width: MediaQuery.of(context).size.width / 1.03,
      decoration: BoxDecoration(
        border: Border.all(
            width: 0.5, color: Colors.white, style: BorderStyle.solid),
        borderRadius: const BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      // height: 50,
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, VideoPlayerValue value, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                vidController.videoDuration(value.position),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 12,
                child: VideoProgressIndicator(
                  padding: const EdgeInsets.only(bottom: 0),
                  colors: const VideoProgressColors(
                    backgroundColor: Colors.black,
                    playedColor: Colors.white,
                  ),
                  controller,
                  allowScrubbing: true,
                ),
              ),
              Text(
                vidController.videoDuration(controller.value.duration),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}