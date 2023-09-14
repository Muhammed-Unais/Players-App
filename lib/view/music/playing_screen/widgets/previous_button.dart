import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:domedia/view/music/playing_screen/controllers/music_playing_control.dart';
import 'package:domedia/view/widgets/playing%20music%20page/play_music_buttons.dart';
import 'package:provider/provider.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({super.key, required this.currentAudioSource});

  final List<SongModel> currentAudioSource;

  @override
  Widget build(BuildContext context) {
    return PlaySongButtons(
      hight: 40,
      width: 40,
      icons: IconButton(
        onPressed: () {
          context.read<MusicPlaying>().previousButton(currentAudioSource,context);
        },
        icon: const Icon(Icons.skip_previous, color: Colors.black),
      ),
    );
  }
}
