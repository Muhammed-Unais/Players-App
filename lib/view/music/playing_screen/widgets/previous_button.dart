import 'package:flutter/material.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/view/widgets/playing%20music%20page/play_music_buttons.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaySongButtons(
      hight: 40,
      width: 40,
      icons: IconButton(
        onPressed: (() async {
            if (PageManger.audioPlayer.hasPrevious) {
              await PageManger.audioPlayer.seekToPrevious();
              PageManger.audioPlayer.play();
            } else {
              PageManger.audioPlayer.play();
          }
        }),
        icon: const Icon(Icons.skip_previous, color: Colors.black),
      ),
    );
  }
}
