import 'package:flutter/material.dart';
import 'package:players_app/view/music/playing_screen/controllers/music_playing_control.dart';
import 'package:players_app/view/music/playing_screen/widgets/next_button.dart';
import 'package:players_app/view/music/playing_screen/widgets/playbutton.dart';
import 'package:players_app/view/music/playing_screen/widgets/previous_button.dart';
import 'package:provider/provider.dart';

class PlayNextPreviousButtons extends StatelessWidget {
  const PlayNextPreviousButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const PreviousButton(),
        Consumer<MusicPlaying>(builder: (context, musicplayingProvider, _) {
          return PlayPausebutton(
            isPlaying: musicplayingProvider.isPlaying,
            function: musicplayingProvider.playButton,
          );
        }),
        const NextButton(),
      ],
    );
  }
}
