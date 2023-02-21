import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/functions/songmodelcontrollers/favouritedbfunctions.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/screens/music/playing_music_page.dart';
import 'package:players_app/screens/music/playlist_screen.dart';
import 'package:players_app/widgets/models/listtale_songs_model.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  @override
  Widget build(BuildContext context) {
    // defining AudioQuery====
    OnAudioQuery audioQuery = OnAudioQuery();
    return FutureBuilder(
      future: audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          sortType: null),
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (item.data!.isEmpty) {
          return const Center(
            child: Text("No Songs Found"),
          );
        }
        PageManger.songscopy = item.data!;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            itemCount: item.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListtaleModelVidSong(
                  leading: QueryArtworkWidget(
                    keepOldArtwork: true,
                    // artworkBorder: BorderRadius.circular(10),
                    artworkWidth: 58,
                    artworkHeight: 58,
                    artworkFit: BoxFit.cover,
                    id: item.data![index].id,
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
                  title: item.data![index].title,
                  subtitle: item.data![index].artist == null ||
                          item.data![index].artist == "<unknown>"
                      ? "Unknown Artist"
                      : item.data![index].artist!,
                  trailingOne: IconButton(
                    onPressed: () async {
                      setState(
                        () {
                          if (FavouriteDb.isFavour(item.data![index])) {
                            FavouriteDb.delete(item.data![index].id);
                          } else {
                            FavouriteDb.add(item.data![index]);
                          }
                        },
                      );

                      FavouriteDb.favouritesSongs.notifyListeners();
                    },
                    icon: FavouriteDb.isFavour(item.data![index])
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                  ),
                  trailingTwo: PopupMenuButton(
                    onSelected: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SongPlaylistScreen(
                              // addtoPlaylist: item.data![index],
                              findex: index,
                              playlistSongsShowornot: false,
                            );
                          },
                        ),
                      );
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: const Text("Add PlayList"),
                        onTap: () {},
                      )
                    ],
                  ),
                  onTap: () {
                    PageManger.audioPlayer.setAudioSource(
                        PageManger.songListCreating(item.data!),
                        initialIndex: index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayinMusicScreen(
                          songModelList: item.data!,
                          count: item.data!.length,
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
    );
  }
}
