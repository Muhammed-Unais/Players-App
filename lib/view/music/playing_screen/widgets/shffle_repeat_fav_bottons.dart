import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/view/music/playing_screen/widgets/favorite_button.dart';
import 'package:players_app/view/music/playing_screen/widgets/repeat_button.dart';
import 'package:players_app/view/music/playing_screen/widgets/shuffle_button.dart';

class ShuffleRepeatFavouriteButtons extends StatelessWidget {
  const ShuffleRepeatFavouriteButtons(
      {super.key, required this.songModelList, required this.index});

  final List<SongModel> songModelList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const ShuffleButton(),
        const RepeatButton(),
        FavoriteButton(
          songModelList: songModelList,
          currentIndex: index,
        )
      ],
    );
  }
}
