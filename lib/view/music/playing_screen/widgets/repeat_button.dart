import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';
import 'package:players_app/view/widgets/playing%20music%20page/play_music_buttons.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaySongButtons(
      icons: IconButton(
        onPressed: () {
          PageManger.audioPlayer.loopMode == LoopMode.one
              ? PageManger.audioPlayer.setLoopMode(LoopMode.all)
              : PageManger.audioPlayer.setLoopMode(LoopMode.one);
        },
        icon: StreamBuilder<LoopMode>(
          stream: PageManger.audioPlayer.loopModeStream,
          builder: (context, snapshot) {
            final loopmode = snapshot.data;
            if (LoopMode.one == loopmode) {
              return const Icon(Icons.repeat_on, color: Colors.black);
            } else {
              return const Icon(
                Icons.repeat,
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
