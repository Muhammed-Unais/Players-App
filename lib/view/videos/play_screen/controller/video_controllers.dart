import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoControllers extends ChangeNotifier {
  bool isPlaying = false;
  bool isLandscape = false;
  bool isShowVideoCntrl = false;
  bool isLocked = false;

  Future setlandScape() async {
    if (isLandscape) {
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
  }

  void landscapeChange() {
    isLandscape = !isLandscape;
    notifyListeners();
  }

  String videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  void controllsVisibility() {
    isShowVideoCntrl == false
        ? isShowVideoCntrl = true
        : isShowVideoCntrl = false;

    notifyListeners();
  }

  void lockButtonfunction() {
    isLocked = !isLocked;
    isShowVideoCntrl = !isShowVideoCntrl;
    notifyListeners();
  }

  void isPauseButton() {
    isPlaying = false;
    notifyListeners();
  }

  void isPlayButton() {
    isPlaying = true;
    notifyListeners();
  }
}
