import 'package:flutter/material.dart';
import 'package:players_app/controllers/functions/songmodelcontrollers/playlistfunctions.dart';
import 'package:players_app/model/db/dbmodel.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/widgets/playlist_scree.dart/snack_bar.dart';
import 'package:provider/provider.dart';

import '../videodbfunctions/videodbplaylist.dart';

updateTextfieldDetails(
    String textediting, int index, bool isSong, test, context) {
  final updatedText = textediting.trim();
  if (updatedText.isEmpty) {
    return;
  }
  if (isSong == true) {
    if (Provider.of<PlaylistDbSong>(context,listen:false).checkSameName(
        Playersmodel(name: updatedText, songid: test))) {
      Snackbars.snackBar(context, "Playlist Already Exist");
    } else {
      // Currentlt playlist working========================================
                // ================================================================
                // ==============================================================
      Provider.of<PlaylistDbSong>(context,listen: false).editPlaylist(
          Playersmodel(name: updatedText, songid: test), index);
      Snackbars.snackBar(context, "Playlist Edited Successfully");
    }
  } else {
    if (PlaylistVideoDb.checkSameName(
      PlayersVideoPlaylistModel(name: updatedText, path: test),
    )) {
      Snackbars.snackBar(context, "Playlist Already Exist");
    }else{
       PlaylistVideoDb.updateVideoPlaylist(
      index,
      PlayersVideoPlaylistModel(name: updatedText, path: test),
    );
    Snackbars.snackBar(context, "Playlist Edited Successfully");
    }
  }
  Navigator.pop(context);
}