import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/favorite_songdb.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';
import 'package:players_app/view/music/playing_screen/playing_music_page.dart';
import 'package:players_app/view/music/playlist/song_playlist_screen.dart';
import 'package:players_app/view/widgets/model_widget/listtale_songs_model.dart';
import 'package:provider/provider.dart';

class AllSongs extends StatelessWidget {
  const AllSongs({super.key});

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
        //==================future builder return container===============//
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

                //=================== Song list tale==================//
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

                //=============== favorite adding screen======================//
                  trailingOne: Consumer<FavouriteSongDb>(
                    builder: (context, favoriteMusic, _) {
                      return IconButton(
                        onPressed: () async {
                          if (favoriteMusic.isFavour(item.data![index])) {
                            favoriteMusic.delete(item.data![index].id);
                          } else {
                            favoriteMusic.add(item.data![index]);
                          }
                        },
                        icon: favoriteMusic.isFavour(item.data![index])
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                              ),
                      );
                    },
                  ),

              //============== playlist adding screen navigtiom===============//
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

            //======= playing music screen from playlist added songs=========//
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
