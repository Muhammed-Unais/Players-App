import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:domedia/model/db/dbmodel.dart';

class SongAddtoPlaylist {
  static void songAddToPlaylist(SongModel song, Playersmodel datas, context) {
    if (!datas.isValueIn(song.id)) {
      datas.add(song.id);

      const snackbar1 = SnackBar(
        duration: Duration(milliseconds: 650),
        backgroundColor: Colors.black,
        content: Text(
          'Song added to Playlist',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar1);
    } else {
      const snackbar2 = SnackBar(
        duration: Duration(milliseconds: 650),
        backgroundColor: Colors.black,
        content: Text(
          'Song Already Exist',
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar2);
    }
  }
}
