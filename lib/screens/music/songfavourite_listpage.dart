import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/functions/songmodelcontrollers/favouritedbfunctions.dart';
import 'package:players_app/screens/music/playing_music_page.dart';
import 'package:players_app/widgets/home%20widgets/home_songs_section.dart';
import 'package:players_app/widgets/models/listtale_songs_model.dart';

class SongFavouriteScreen extends StatefulWidget {
  const SongFavouriteScreen({super.key});

  @override
  State<SongFavouriteScreen> createState() => _SongFavouriteScreenState();
}

class _SongFavouriteScreenState extends State<SongFavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    // Intializing FavouriteDB========
    if (!FavouriteDb.isIntialized) {
      FavouriteDb.isIntializ(songmodel);
    }
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
      body: ValueListenableBuilder(
        valueListenable: FavouriteDb.favouritesSongs,
        builder: (context, item, child) {
          return FavouriteDb.favouritesSongs.value.isEmpty
              ? const Center(
                  child: Text(
                    "No Favorites",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListtaleModelVidSong(
                          leading: QueryArtworkWidget(
                            artworkWidth: 58,
                            artworkHeight: 58,
                            artworkFit: BoxFit.cover,
                            id: item[index].id,
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
                          title: item[index].displayNameWOExt,
                          subtitle: item[index].artist == null ||
                                  item[index].artist == "<unknown>"
                              ? "Unknown Artist"
                              : item[index].artist!,
                          trailingOne: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  if (FavouriteDb.isFavour(item[index])) {
                                    FavouriteDb.delete(item[index].id);
                                  }
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            PageManger.audioPlayer.setAudioSource(
                                PageManger.songListCreating(item),
                                initialIndex: index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayinMusicScreen(
                                  songModelList: item,
                                  count: item.length,
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
