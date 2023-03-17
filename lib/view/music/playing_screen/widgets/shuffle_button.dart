import 'package:flutter/material.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/view/widgets/playing%20music%20page/play_music_buttons.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({super.key});


  @override
  Widget build(BuildContext context) {
    bool isShuffle = false;
    return PlaySongButtons(
      icons: IconButton(
        onPressed: () {
          isShuffle == false
              ? PageManger.audioPlayer.setShuffleModeEnabled(true)
              : PageManger.audioPlayer.setShuffleModeEnabled(false);
        },
        icon: StreamBuilder<bool>(
          stream: PageManger.audioPlayer.shuffleModeEnabledStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              isShuffle = snapshot.data;
            }
            if (isShuffle) {
              return const Icon(Icons.shuffle_on_outlined, color: Colors.black);
            } else {
              return const Icon(
                Icons.shuffle,
                color: Colors.black,
              );
            }
          },
        ),
      ),
      width: 40,
      hight: 40,
    );
  }
}
