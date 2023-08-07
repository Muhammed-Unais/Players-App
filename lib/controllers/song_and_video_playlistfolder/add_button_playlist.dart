import 'package:flutter/material.dart';
import 'package:players_app/controllers/song_folder/playlist_db_song.dart';
import 'package:players_app/model/db/dbmodel.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/widgets/playlist_scree.dart/snack_bar.dart';
import 'package:provider/provider.dart';

import '../video_folder/videodbplaylist.dart';

class AddButtonPlaylist {
  static addbuttonPressed(String textediting, bool isSong, context) {
    final text = textediting.trim();
    if (text.isEmpty) {
      return;
    }
    if (isSong == true) {
      if (Provider.of<PlaylistDbSong>(context, listen: false).checkSameName(
        Playersmodel(
          name: text,
          songid: [],
        ),
      )) {
        Snackbars.snackBar(context, "Playlist Already Exist");
      } else {
        Provider.of<PlaylistDbSong>(context, listen: false).add(
          Playersmodel(
            name: text,
            songid: [],
          ),
        );
        Snackbars.snackBar(context, "Playlist Created Successfully");
      }
    } else {
      if (Provider.of<PlaylistVideoDb>(context, listen: false).checkSameName(
        PlayersVideoPlaylistModel(
          name: text,
          path: [],
        ),
      )) {
        Snackbars.snackBar(context, "Playlist Already Exist");
      } else {
        Provider.of<PlaylistVideoDb>(context, listen: false).add(
          PlayersVideoPlaylistModel(
            name: text,
            path: [],
          ),
        );
        Snackbars.snackBar(context, "Playlist Created Successfully");
      }
    }
    Navigator.pop(context);
  }
}
