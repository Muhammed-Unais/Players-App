import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoControllers extends ChangeNotifier {
  VideoPlayerController? controllers;
  int _isPlayingindex = -1;
  bool isPlaying = false;
  bool isLandscape = false;
  bool isShowVideoCntrl = false;
  bool isLocked = false;

  // VideoPlayerController? get controller => controller;
  int get isPlayingindex => _isPlayingindex;
  // bool get isPlaying => _isPlaying;

  // =================Intialize Video===============
  intializeVideo(
      {required int index, required List paths, required bool isModelorPath}) {
    final controller = VideoPlayerController.file(
      File(
        isModelorPath == true ? paths[index].path : paths[index],
      ),
    );
    controllersvalue(controller);
    // notifyListeners();
    controller.initialize().then((_) {
      // old!.dispose();
      controller.addListener(_oncontrollUpdate);
      controller.play();
      notifyListeners();
    });

    _isPlayingindex = index;
  }

  controllersvalue(controller) {
    controllers = controller;
    // notifyListeners();
  }

  vidoeControllers() {
    controllers!.pause();
  }

  //=============== Listening Function==========================
  void _oncontrollUpdate() async {
    final controller = controllers;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) return;
    final playing = controller.value.isPlaying;
    isPlaying = playing;
  }

  //====================== Set landscape======================
  Future setlandScape() async {
    if (isLandscape) {
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
  }

  landscapeChange() {
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

  //================Controlls visibility function===============================
  controllsVisibility() async {
    isShowVideoCntrl == false ? isShowVideoCntrl = true : null;
    notifyListeners();
    if (isShowVideoCntrl == true) {
      await Future.delayed(const Duration(seconds: 5));

      isShowVideoCntrl = false;
      notifyListeners();
    }
  }

  lockButtonfunction() {
    isLocked = !isLocked;
    isShowVideoCntrl = !isShowVideoCntrl;
    notifyListeners();
  }

  isPauseButton() {
    isPlaying = false;
    notifyListeners();
  }

  isPlayButton() {
    isPlaying = true;
    notifyListeners();
  }

  videoControllersShow() {
    isShowVideoCntrl = false;
    notifyListeners();
  }
}
