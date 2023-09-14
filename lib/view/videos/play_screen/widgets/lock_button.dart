import 'package:flutter/material.dart';
import 'package:domedia/view/videos/play_screen/controller/video_controllers.dart';
import 'package:provider/provider.dart';

class LockButton extends StatelessWidget {
  const LockButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vidController = Provider.of<VideoControllers>(context);
    return vidController.isShowVideoCntrl ||
            vidController.isLocked ? IconButton(
      onPressed: () => vidController.lockButtonfunction(),
      icon: vidController.isLocked 
          ? Icon(
              Icons.lock_outline,
              color: Colors.white.withOpacity(0.5),
              size: 20,
            )
          : const Icon(
              Icons.lock_open_outlined,
              color: Colors.white,
              size: 20,
            ),
    ):const SizedBox();
  }
}
