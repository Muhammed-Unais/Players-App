import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayinMusicCircleAvatar extends StatelessWidget {
  final SongModel songs;
  const PlayinMusicCircleAvatar({
    super.key,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: CircleAvatar(
        radius: size.width*0.3,
        backgroundColor: Colors.grey.shade400,
        child: QueryArtworkWidget(
          keepOldArtwork: true,
          artworkBorder: BorderRadius.circular(200),
          artworkWidth: size.width*0.58,
          artworkHeight: size.width*0.58,
          artworkFit: BoxFit.cover,
          id: songs.id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage:
                const AssetImage("assets/images/pexels-foteros-352505.jpg"),
            radius:  size.width*0.29,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.music_note_outlined,
                    color: Colors.white.withAlpha(105),
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
