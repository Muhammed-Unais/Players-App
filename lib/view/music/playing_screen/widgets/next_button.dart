import 'package:flutter/material.dart';
import 'package:players_app/view/music/playing_screen/controllers/music_playing_control.dart';
import 'package:players_app/view/widgets/playing%20music%20page/play_music_buttons.dart';
import 'package:provider/provider.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaySongButtons(
      icons: IconButton(
          onPressed: context.read<MusicPlaying>().nextButton,
          icon: const Icon(
            Icons.skip_next,
            color: Colors.black,
          ),
          tooltip: "Skip Next"),
      width: 40,
      hight: 40,
    );
  }
}
