import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/view/widgets/thumbnail.dart';

class SearchLeading extends StatelessWidget {
  const SearchLeading(
      {super.key,
      required this.isSong,
      required this.songModel,required this.videoModel,
     });

  final bool isSong;
  final SongModel songModel;
  final dynamic videoModel;

  @override
  Widget build(BuildContext context) {
    return isSong == true
        ? QueryArtworkWidget(
            artworkWidth: 58,
            artworkHeight: 58,
            id: songModel.id,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage:
                  const AssetImage("assets/images/pexels-foteros-352505.jpg"),
              radius: 30,
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
          )
        : thumbnail(path: videoModel, choice: true);
  }
}
