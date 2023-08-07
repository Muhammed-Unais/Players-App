import 'package:flutter/material.dart';
import 'package:players_app/model/db/videodb_model.dart';

class VideoAddToPlaylist {
  static void videoAddToPlaylist(
      String path, PlayersVideoPlaylistModel viddatas, context) {
    if (!viddatas.isValueIn(path)) {
      viddatas.add(path);
      const vaddSnackbar1 = SnackBar(
        duration: Duration(milliseconds: 650),
        backgroundColor: Colors.black,
        content: Text(
          'Video added to Playlist',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(vaddSnackbar1);
    } else {
      const vaddSnackbar2 = SnackBar(
        duration: Duration(milliseconds: 650),
        backgroundColor: Colors.black,
        content: Text(
          'Video Already Exisit',
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(vaddSnackbar2);
    }
  }
}
