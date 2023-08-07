import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/favorite_songdb.dart';
import 'package:players_app/view/music/playlist/song_playlist_screen.dart';
import 'package:provider/provider.dart';

class SongTrailing extends StatelessWidget {
  const SongTrailing({super.key, required this.songModel, required this.index});

  final SongModel songModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ============Favorite Icon(adding & deleting)=============
// currently working ===========================================================================================================
        Consumer<FavouriteSongDb>(
          builder: (context, favouriteMusic, _) {
            return IconButton(
              onPressed: () async {
                if (favouriteMusic.isFavour(songModel)) {
                  favouriteMusic.delete(songModel.id);
                } else {
                  favouriteMusic.add(songModel);
                }
              },
              icon: favouriteMusic.isFavour(songModel)
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

        // ===========Morevert ICon For Add Playlist==============
        PopupMenuButton(
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
        )
      ],
    );
  }
}
