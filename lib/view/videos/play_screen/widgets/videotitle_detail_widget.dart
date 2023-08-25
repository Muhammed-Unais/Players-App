import 'package:flutter/material.dart';
import 'package:players_app/view/videos/play_screen/controller/video_controllers.dart';
import 'package:provider/provider.dart';

class VideoTitleDetailWidget extends StatelessWidget {
  const VideoTitleDetailWidget({
    super.key,
    required this.videoTitle,
  });

  final String videoTitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoControllers>(
      builder: (context, videoPlayerProvider, _) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          color: videoPlayerProvider.isShowVideoCntrl
              ? Colors.transparent.withAlpha(150)
              : Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              videoPlayerProvider.isShowVideoCntrl
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox(),
              SizedBox(width: MediaQuery.of(context).size.width / 100 * 2),
              videoPlayerProvider.isShowVideoCntrl
                  ? Text(
                      videoTitle,
                      style: const TextStyle(color: Colors.white),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
