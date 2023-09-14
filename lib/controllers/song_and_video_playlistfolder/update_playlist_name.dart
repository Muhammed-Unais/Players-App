import 'package:flutter/material.dart';
import 'package:domedia/controllers/song_folder/playlist_db_song.dart';
import 'package:domedia/model/db/dbmodel.dart';
import 'package:domedia/model/db/videodb_model.dart';
import 'package:domedia/view/widgets/playlist_scree.dart/snack_bar.dart';
import 'package:provider/provider.dart';
import '../video_folder/videodbplaylist.dart';

class UpdateVideoSongPlaylistName {
  static updateTextfieldDetails(
      String textediting, int index, bool isSong, test, context) {
    final updatedText = textediting.trim();
    if (updatedText.isEmpty) {
      return;
    }
    if (isSong == true) {
      if (Provider.of<PlaylistDbSong>(context, listen: false)
          .checkSameName(Playersmodel(name: updatedText, songid: test))) {
        Snackbars.snackBar(context, "Playlist Already Exist");
      } else {
        Provider.of<PlaylistDbSong>(context, listen: false)
            .editPlaylist(Playersmodel(name: updatedText, songid: test), index);
        Snackbars.snackBar(context, "Playlist Edited Successfully");
      }
    } else {
      if (Provider.of<PlaylistVideoDb>(context, listen: false).checkSameName(
        PlayersVideoPlaylistModel(name: updatedText, path: test),
      )) {
        Snackbars.snackBar(context, "Playlist Already Exist");
      } else {
        Provider.of<PlaylistVideoDb>(context, listen: false)
            .updateVideoPlaylist(
          index,
          PlayersVideoPlaylistModel(name: updatedText, path: test),
        );
        Snackbars.snackBar(context, "Playlist Edited Successfully");
      }
    }
    Navigator.pop(context);
  }
}
