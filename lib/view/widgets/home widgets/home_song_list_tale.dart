import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';
import 'package:players_app/view/music/playing_screen/playing_music_page.dart';

class SongsListTile extends StatelessWidget {
  const SongsListTile({
    super.key,
    required this.songModel,
    required this.index,
  });

  final List<SongModel> songModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const LinearGradient(
          colors: [Color(0xffd1d1d1), Color(0xffe8e8e8)],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0.1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: QueryArtworkWidget(
          keepOldArtwork: true,
          artworkWidth: 48,
          artworkHeight: 48,
          artworkFit: BoxFit.cover,
          id: songModel[index].id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: const CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage:
                AssetImage("assets/images/pexels-foteros-352505.jpg"),
            radius: 24,
          ),
        ),
        title: Text(
          songModel[index].title,
          style: GoogleFonts.raleway(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        subtitle: Text(
          songModel[index].artist == null ||
                  songModel[index].artist == "<unknown>"
              ? "Unknown Artist"
              : songModel[index].artist!,
          style: GoogleFonts.raleway(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          IconlyBold.play,
          color: Colors.black,
        ),
        onTap: () {
          PageManger.audioPlayer.setAudioSource(
            PageManger.songListCreating(songModel),
            initialIndex: index,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PlayingMusicScreen(
                  songModelList: songModel,
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
