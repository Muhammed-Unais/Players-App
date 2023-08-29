import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_and_video_playlistfolder/alert_dialotgue_songs_video_delete.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';
import 'package:players_app/controllers/song_folder/favorite_songdb.dart';
import 'package:players_app/view/music/playing_screen/playing_music_page.dart';
import 'package:players_app/view/widgets/model_widget/listtale_songs_model.dart';
import 'package:provider/provider.dart';

class SongFavouriteScreen extends StatelessWidget {
  const SongFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Songs Fovorite",
          style: GoogleFonts.raleway(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Consumer<FavouriteSongDb>(
        builder: (context, favouriteMusic, _) {
          if (!favouriteMusic.isIntialized) {
            favouriteMusic.isIntializ(PageManger.songscopy);
          }
          return favouriteMusic.favouritesSongs.isEmpty
              ? Center(
                  child: Text(
                    "No Favorites",
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: favouriteMusic.favouritesSongs.length,
                    itemBuilder: (context, index) {
                      var favSongs = favouriteMusic.favouritesSongs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListtaleModelVidSong(
                          leading: QueryArtworkWidget(
                            artworkWidth: 58,
                            artworkHeight: 58,
                            artworkFit: BoxFit.cover,
                            id: favSongs.id,
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
                          title: favSongs.displayNameWOExt,
                          subtitle: favSongs.artist == null ||
                                  favSongs.artist == "<unknown>"
                              ? "Unknown Artist"
                              : favSongs.artist!,
                          trailingOne: IconButton(
                            onPressed: () {
                              deleteVideoAndSongs(context, "Delete", () {
                                if (favouriteMusic.isFavour(favSongs)) {
                                  favouriteMusic.delete(favSongs.id);
                                }
                                Navigator.pop(context);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            PageManger.audioPlayer.setAudioSource(
                                PageManger.songListCreating(
                                    favouriteMusic.favouritesSongs),
                                initialIndex: index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayingMusicScreen(
                                  index: index,
                                  songModelList: favouriteMusic.favouritesSongs,
                                  count: favouriteMusic.favouritesSongs.length,
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
}
