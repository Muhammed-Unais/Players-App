import 'package:flutter/material.dart';
import 'package:players_app/controllers/song_folder/playlist_db_song.dart';
import 'package:players_app/controllers/video_folder/videodbplaylist.dart';
import 'package:provider/provider.dart';

class SongVideoDeleteFromPlaylist {
  static showDialougeForDelete(context, isForSong, index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Delete",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Are you sure you want to Delete Playlist",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                isForSong == true
                    ? Provider.of<PlaylistDbSong>(context, listen: false)
                        .deletePlaylist(index)
                    : Provider.of<PlaylistVideoDb>(context, listen: false)
                        .deleteVideoPlaylist(index);
                // ==========================================
                const snackBar = SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(
                    'Playlist is deleted',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(milliseconds: 350),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              },
              child: const Text(
                "Sure",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
