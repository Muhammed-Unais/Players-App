import 'package:flutter/material.dart';
import 'package:players_app/functions/new_playlist.dart';
import 'package:players_app/functions/show_dialougeplaylist_deleteboth.dart';

Widget editAndDeleteDialoge({ctx, index, required bool isforSong, test}) {
  return PopupMenuButton(
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: Colors.white,
    onSelected: (value) {
      if (value == 1) {
        newPlaylistAdd(
            test: test,
            isSong: isforSong,
            isCreate: false,
            titile: "Update a Playlist",
            context: ctx,
            index: index);
      }
      if (value == 2) {
        showDialougeForDelete(ctx, isforSong, index);
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