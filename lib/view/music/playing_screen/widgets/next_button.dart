import 'package:flutter/material.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/view/widgets/playing%20music%20page/play_music_buttons.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaySongButtons(
      icons: IconButton(
          onPressed: () async {
            if (PageManger.audioPlayer.hasNext) {
              await PageManger.audioPlayer.seekToNext();
              PageManger.audioPlayer.play();
            } else {
              PageManger.audioPlayer.play();
            }
          },
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
