import 'package:flutter/material.dart';
import 'package:players_app/controllers/song_and_video_playlistfolder/add_button_playlist.dart';
import 'package:players_app/controllers/song_and_video_playlistfolder/update_playlist_name.dart';
import 'package:players_app/view/music/playlist/song_playlist_screen.dart';

class NewOrEditPlaylist {
  static void newPlaylistAdd(
      {context,
      index,
      test,
      required String titile,
      required bool isCreate,
      required bool isSong}) {
    TextEditingController textEditingController = TextEditingController();
    String textediting = textEditingController.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titile),
          content: Form(
            key: formkey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Playlist Name";
                }
                return null;
              },
              onChanged: (value) {
                textediting = value;
              },
              controller: textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  isCreate == true
                      // =======================================
                      ? AddButtonPlaylist.addbuttonPressed(
                          textediting, isSong, context)
                      : UpdateVideoSongPlaylistName.updateTextfieldDetails(
                          textediting, index, isSong, test, context);
                  // ===========================================
                }
              },
              child: Text(
                isCreate == true ? "Create" : "Update",
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
