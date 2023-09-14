import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:domedia/controllers/song_folder/playlist_db_song.dart';
import 'package:domedia/controllers/video_folder/videodbplaylist.dart';
import 'package:provider/provider.dart';

class SongVideoDeleteFromPlaylist {
  static showDialougeForDelete(context, isForSong, index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Delete",
            style: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          content: Text(
            "Do you want to delete playlist",
            style: GoogleFonts.raleway(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "No",
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
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
              child: Text(
                "Sure",
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
