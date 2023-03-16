import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/functions/playlist_add_and_minimize.dart';
import 'package:players_app/model/db/dbmodel.dart';
import 'package:provider/provider.dart';

class SongAddingPlaylist extends StatelessWidget {
  const SongAddingPlaylist({super.key, required this.playlist});
  final Playersmodel playlist;

  @override
  Widget build(BuildContext context) {
    OnAudioQuery audioQuery = OnAudioQuery();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        future: audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            sortType: null),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text("No Songs Found"),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListTile(
                  tileColor: Colors.white,
                  contentPadding: const EdgeInsets.all(0),
                  leading: QueryArtworkWidget(
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
                  title: Text(item.data![index].displayNameWOExt),
                  subtitle: Text(item.data![index].artist == null ||
                          item.data![index].artist == "<unknown>"
                      ? "Unknown Artist"
                      : item.data![index].artist!),

                  // Currentlt playlist working========================================
                  // ================================================================
                  // ==============================================================
                  trailing: Consumer<Test>(
                    builder: (context, test, child) {
                      return IconButton(
                        onPressed: () {
                          bool isValueIn =
                              playlist.isValueIn(item.data![index].id);
                          if (!isValueIn) {
                            test.add(
                                id: item.data![index].id,
                                playersmodel: playlist);
                          } else {
                            test.delete(
                                id: item.data![index].id,
                                playersmodel: playlist);
                          }
                        },
                        icon: playlist.isValueIn(
                          item.data![index].id,
                        )
                            ? const Icon(Icons.minimize)
                            : const Icon(Icons.add),
                      );
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0,
              );
            },
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
