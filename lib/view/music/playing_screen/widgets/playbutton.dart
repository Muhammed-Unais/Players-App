import 'package:flutter/material.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';
import 'package:players_app/view/widgets/playing%20music%20page/play_music_buttons.dart';

class PlayPausebutton extends StatelessWidget {
  const PlayPausebutton({super.key, required this.isPlaying, required this.function});

  final bool isPlaying;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return PlaySongButtons(
      width: 60,
      hight: 60,
      icons: IconButton(
        onPressed: function,
        icon: Icon(
          PageManger.audioPlayer.playing ? Icons.pause : Icons.play_arrow,
          color: Colors.black,
        ),
        tooltip: isPlaying ? "Pause" : "Play",
      ),
    );
  }
}
