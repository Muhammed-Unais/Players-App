import 'package:flutter/material.dart';
import 'package:players_app/controllers/song_and_video_playlistfolder/new_or_edit_playlist.dart';
import 'package:players_app/controllers/song_and_video_playlistfolder/song_video_delete_inplaylist.dart';

Widget editAndDeleteDialoge({ctx, index, required bool isforSong, test}) {
  return PopupMenuButton(
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: Colors.white,
    icon: const Icon(Icons.more_vert,color: Colors.black,),
    onSelected: (value) {
      if (value == 1) {
        NewOrEditPlaylist.newPlaylistAdd(
            test: test,
            isSong: isforSong,
            isCreate: false,
            titile: "Update a Playlist",
            context: ctx,
            index: index);
      }
      if (value == 2) {
        SongVideoDeleteFromPlaylist.showDialougeForDelete(ctx, isforSong, index);
      }
    },
    itemBuilder: (ctx) {
      return [
        PopupMenuItem(
          value: 1,
          child: const Text("Edit"),
          onTap: () {},
        ),
        PopupMenuItem(
          value: 2,
          child: const Text("Delete"),
          onTap: () {
            // =====================================

            // Navigator.pop(ctx);
          },
        ),
      ];
    },
  );
}