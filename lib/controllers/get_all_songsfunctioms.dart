import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'package:on_audio_query/on_audio_query.dart';

class PageManger {
  final currentSongTitleNotifier = ValueNotifier<String>('');

  static AudioPlayer audioPlayer = AudioPlayer();
  static List<SongModel> songscopy = [];
  static int currerentIndexes = -1;
  static ConcatenatingAudioSource songListCreating(List<SongModel> elements) {
    List<AudioSource> songList = [];
    for (var element in elements) {
      songList.add(
        AudioSource.uri(
          tag: currerentIndexes,
          Uri.parse(element.uri!),
        ),
      );
    }
    return ConcatenatingAudioSource(children: songList);
  }

  static void dispose() {
    audioPlayer.dispose();
  }

  static void play() async {
    audioPlayer.play();
  }
  static void pause() async {
    audioPlayer.pause();
  }
}
