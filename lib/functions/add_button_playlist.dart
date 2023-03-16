import 'package:flutter/material.dart';
import 'package:players_app/functions/songmodelcontrollers/playlistfunctions.dart';
import 'package:players_app/model/db/dbmodel.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/widgets/playlist_scree.dart/snack_bar.dart';
import 'package:provider/provider.dart';

import 'videodbfunctions/videodbplaylist.dart';

addbuttonPressed(String textediting, bool isSong, context) {
  final text = textediting.trim();
  if (text.isEmpty) {
    return;
  }
  if (isSong == true) {
    if (Provider.of<PlaylistDbSong>(context,listen: false).checkSameName(
      Playersmodel(
        name: text,
        songid: [],
      ),
    )) {
      Snackbars.snackBar(context, "Playlist Already Exist");
    } else {
      // Currentlt playlist working========================================
                // ================================================================
                // ==============================================================
      Provider.of<PlaylistDbSong>(context,listen: false).add(
        Playersmodel(
          name: text,
          songid: [],
        ),
      );
      Snackbars.snackBar(context, "Playlist Created Successfully");
    }
  } else {
    if (PlaylistVideoDb.checkSameName(
      PlayersVideoPlaylistModel(
        name: text,
        path: [],
      ),
    )) {
      Snackbars.snackBar(context, "Playlist Already Exist");
    } else {
      PlaylistVideoDb.add(
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