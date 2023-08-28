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
    final size = MediaQuery.of(context).size;
    OnAudioQuery audioQuery = OnAudioQuery();
    return FutureBuilder(
      future: audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          sortType: null),
      builder: (context, item) {
        if (item.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (item.connectionState == ConnectionState.done &&
            item.data!.isEmpty) {
          return Center(
            child: SizedBox(
              height: size.height * 0.4,
              width: size.width * 0.8,
              child: Image.asset("assets/images/Add files-rafiki.png"),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(left: 16, right: 16),
          shrinkWrap: true,
          itemCount: item.data!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: ListtaleModelVidSong(
                leading: QueryArtworkWidget(
                  keepOldArtwork: true,
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
                    const PopupMenuItem(
                      value: 1,
                      child: Text("Add PlayList"),
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
                      builder: (context) => PlayingMusicScreen(
                        index: index,
                        songModelList: item.data!,
                        count: item.data!.length,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
