import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/controllers/functions/songmodelcontrollers/favouritedbfunctions.dart';
import 'package:players_app/view/music/playing_screen/playing_music_page.dart';
import 'package:players_app/view/widgets/home%20widgets/home_songs_section.dart';
import 'package:players_app/view/widgets/models/listtale_songs_model.dart';
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
      body: Consumer<FavouriteMusicDb>(
        builder: (context, favouriteMusic, _) {
          if (!favouriteMusic.isIntialized) {
            favouriteMusic.isIntializ(songmodel);
          }
          return favouriteMusic.favouritesSongs.isEmpty
              ? const Center(
                  child: Text(
                    "No Favorites",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: favouriteMusic.favouritesSongs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListtaleModelVidSong(
                          leading: QueryArtworkWidget(
                            artworkWidth: 58,
                            artworkHeight: 58,
                            artworkFit: BoxFit.cover,
                            id: favouriteMusic.favouritesSongs[index].id,
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
                          title: favouriteMusic
                              .favouritesSongs[index].displayNameWOExt,
                          subtitle: favouriteMusic
                                          .favouritesSongs[index].artist ==
                                      null ||
                                  favouriteMusic
                                          .favouritesSongs[index].artist ==
                                      "<unknown>"
                              ? "Unknown Artist"
                              : favouriteMusic.favouritesSongs[index].artist!,
                          trailingOne: IconButton(
                            onPressed: () {
                              if (favouriteMusic.isFavour(
                                  favouriteMusic.favouritesSongs[index])) {
                                favouriteMusic.delete(
                                    favouriteMusic.favouritesSongs[index].id);
                              }
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
                                builder: (context) => PlayinMusicScreen(
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
