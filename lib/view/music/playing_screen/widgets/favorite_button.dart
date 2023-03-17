import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/functions/songmodelcontrollers/favouritedbfunctions.dart';
import 'package:players_app/view/widgets/playing%20music%20page/play_music_buttons.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.currentIndex, required this.songModelList});

  final int currentIndex;
  final List<SongModel> songModelList;

  @override
  Widget build(BuildContext context) {
    return PlaySongButtons(
      // currently working ============================================================================================
      icons: Consumer<FavouriteMusicDb>(
        builder: (context, favouriteMusic, _) {
          return IconButton(
            onPressed: () {
              if (favouriteMusic
                  .isFavour(songModelList[currentIndex])) {
                favouriteMusic
                    .delete(songModelList[currentIndex].id);
              } else {
                favouriteMusic
                    .add(songModelList[currentIndex]);
              }
            },
            icon: favouriteMusic
                    .isFavour(songModelList[currentIndex])
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
      width: 40,
      hight: 40,
    );
  }
}
