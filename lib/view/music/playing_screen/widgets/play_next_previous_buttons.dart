import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:domedia/view/music/playing_screen/controllers/music_playing_control.dart';
import 'package:domedia/view/music/playing_screen/widgets/next_button.dart';
import 'package:domedia/view/music/playing_screen/widgets/playbutton.dart';
import 'package:domedia/view/music/playing_screen/widgets/previous_button.dart';
import 'package:provider/provider.dart';

class PlayNextPreviousButtons extends StatelessWidget {
  const PlayNextPreviousButtons({super.key, required this.currentAudioSource});

  final List<SongModel> currentAudioSource;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PreviousButton(currentAudioSource: currentAudioSource),
        Consumer<MusicPlaying>(
          builder: (context, musicplayingProvider, _) {
            return PlayPausebutton(
              isPlaying: musicplayingProvider.isPlaying,
              function: musicplayingProvider.playButton,
            );
          },
        ),
         NextButton(currentAudioSource: currentAudioSource),
      ],
    );
  }
}
