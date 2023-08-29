import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            titile,
            style: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
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
                focusColor: Colors.black,
                
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
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
              child: Text(
                "Cancel",
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  if (isCreate) {
                    AddButtonPlaylist.addbuttonPressed(
                        textediting, isSong, context);
                  } else {
                    UpdateVideoSongPlaylistName.updateTextfieldDetails(
                        textediting, index, isSong, test, context);
                  }
                }
              },
              child: Text(
                isCreate == true ? "Create" : "Update",
                style: GoogleFonts.raleway(
                  fontSize: 16,
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
