import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';
import 'package:players_app/model/db/dbmodel.dart';
import 'package:players_app/view/music/playlist/song_adding_playlist.dart';
import 'package:players_app/view/widgets/model_widget/listtale_songs_model.dart';
import '../playing_screen/playing_music_page.dart';

class PlaylistSongsList extends StatelessWidget {
  final int findex;
  final Playersmodel playlist;
  const PlaylistSongsList(
      {super.key, required this.findex, required this.playlist});

  @override
  Widget build(BuildContext context) {
    late List<SongModel> songsPlaylist;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          "Add Songs",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SongAddingPlaylist(
                  playlist: playlist,
                );
              },
            ),
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          playlist.name,
          style: GoogleFonts.raleway(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Playersmodel>('SongPlaylistDB').listenable(),
        builder: (context, musics, _) {
          // here findex is playlist folder index so in this index we have players model class.in the class we have song id int type list.here that is assaigned to songs playlist
          songsPlaylist = listPlaylist(musics.values.toList()[findex].songid);
          return songsPlaylist.isEmpty
              ? const Center(
                  child: Text(
                    "Add Your Playlist",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: songsPlaylist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListtaleModelVidSong(
                          leading: QueryArtworkWidget(
                            artworkWidth: 58,
                            artworkHeight: 58,
                            artworkFit: BoxFit.cover,
                            id: songsPlaylist[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage: const AssetImage(
                                  "assets/images/pexels-foteros-352505.jpg"),
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
                          ),
                          title: songsPlaylist[index].displayNameWOExt,
                          subtitle: songsPlaylist[index].artist == null ||
                                  songsPlaylist[index].artist == "<unknown>"
                              ? "Unknown Artist"
                              : songsPlaylist[index].artist!,
                          trailingOne: IconButton(
                            onPressed: () {
                              playlist.deleteData(songsPlaylist[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            List<SongModel> newMusicList = [...songsPlaylist];
                            PageManger.audioPlayer.stop();
                            PageManger.audioPlayer.setAudioSource(
                                PageManger.songListCreating(newMusicList),
                                initialIndex: index);
                            PageManger.audioPlayer.play();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => PlayinMusicScreen(
                                  songModelList: songsPlaylist,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (var i = 0; i < PageManger.songscopy.length; i++) {
      for (var j = 0; j < data.length; j++) {
        if (PageManger.songscopy[i].id == data[j]) {
          plsongs.add(PageManger.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
