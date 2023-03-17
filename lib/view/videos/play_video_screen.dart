import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreen extends StatefulWidget {
  final List paths;
  final int index;
  final bool isModelorPath;

  const PlayVideoScreen(
      {super.key,
      required this.paths,
      required this.index,
      required this.isModelorPath});

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  VideoPlayerController? _controller;
  bool isLandscape = false;
  int isPlayingindex = -1;
  bool _isPlaying = false;
  bool isShowVideoCntrl = false;
  bool isLocked = false;

  @override
  void initState() {
    super.initState();
    intializeVideo(widget.index);
  }

  @override
  void dispose() {
    _controller!.pause();
    _controller!.dispose();
    _controller = null;
    super.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  // =================Intialize Video===============
  intializeVideo(int index) {
    final controller = VideoPlayerController.file(
      File(
        widget.isModelorPath == true
            ? widget.paths[index].path
            : widget.paths[index],
      ),
    );
    _controller = controller;
    if (mounted) {
      setState(() {});
    }
    controller.initialize().then((_) {
      // old!.dispose();
      controller.addListener(_oncontrollUpdate);
      controller.play();
      if (mounted) {
        setState(() {});
      }
    });

    isPlayingindex = index;
  }

  //=============== Listening Function==========================
  void _oncontrollUpdate() async {
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) return;
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
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

  String videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

//================Controlls visibility function===============================
  controllsVisibility() async {
    setState(() {
      isShowVideoCntrl == false ? isShowVideoCntrl = true : null;
    });
    if (isShowVideoCntrl == true) {
      await Future.delayed(const Duration(seconds: 5));

      if (mounted) {
        setState(
          () {
            isShowVideoCntrl = false;
          },
        );
      }
    }
  }

  int count = 0;
  int pcount = 1;

//===================controlls lock button=============================
  Widget lockButton() {
    return isShowVideoCntrl == true || isLocked == true
        ? IconButton(
            onPressed: () {
              setState(
                () {
                  isLocked = !isLocked;
                  isShowVideoCntrl = !isShowVideoCntrl;
                },
              );
            },
            icon: isLocked == true
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
          )
        : const SizedBox();
  }

//======================== Build Ui function=====================
  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return GestureDetector(
      onTap: () async {
        if (isLocked == true) return;
        if (pcount != count) {
          count++;
          await controllsVisibility();
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
                //=======================Video playing area =======================
                controller != null && controller.value.isInitialized
                    ? Align(
                        alignment: Alignment.center,
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        ),
                      )
                    : const AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                //==================================Video Upper area=============================
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    color: isShowVideoCntrl == true
                        ? Colors.transparent.withAlpha(150)
                        : Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isShowVideoCntrl == true
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
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 100 * 2),
                        isShowVideoCntrl == true
                            ? Text(
                                widget.isModelorPath == true
                                    ? widget.paths[isPlayingindex].path
                                        .toString()
                                        .split('/')
                                        .last
                                    : widget.paths[isPlayingindex]
                                        .toString()
                                        .split('/')
                                        .last,
                                style: const TextStyle(color: Colors.white),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),

                //==============================Video Controllers Area =====================================
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: isShowVideoCntrl == true
                        ? Colors.transparent.withAlpha(150)
                        : Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isShowVideoCntrl == true
                            ? controlls(context, controller!)
                            : const SizedBox(),
                        const SizedBox(
                          height: 12,
                        ),
                        controlerButtons(context, controller!),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// =================VIDEO CONTROLLERS=============
  Widget controlls(BuildContext context, VideoPlayerController controller) {
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
                videoDuration(value.position),
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
                videoDuration(controller.value.duration),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget controlerButtons(context, VideoPlayerController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            lockButton(),
            isShowVideoCntrl == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          final index = isPlayingindex - 1;
                          if (index >= 0 && widget.paths.isNotEmpty) {
                            intializeVideo(index);
                          }
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 12,
                      ),
                      // ===========================Video Play and pause button=========================
                      IconButton(
                        onPressed: () async {
                          if (_isPlaying) {
                            setState(
                              () {
                                _isPlaying = false;
                              },
                            );
                            _controller!.pause();
                            await Future.delayed(const Duration(seconds: 5));
                            if (mounted) {
                              setState(
                                () {
                                  isShowVideoCntrl = false;
                                },
                              );
                            }
                          } else {
                            setState(
                              () {
                                _isPlaying = true;
                              },
                            );
                            _controller!.play();
                          }
                        },
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 12,
                      ),
                      IconButton(
                        onPressed: () {
                          final index = isPlayingindex + 1;
                          if (index <= widget.paths.length - 1) {
                            intializeVideo(index);
                          }
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            isShowVideoCntrl == true ? fullScreenRotate() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget fullScreenRotate() {
    return IconButton(
      onPressed: () {
        setState(
          () {
            setlandScape();
            isLandscape = !isLandscape;
          },
        );
      },
      icon: const Icon(
        Icons.screen_rotation,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
