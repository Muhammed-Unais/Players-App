import 'package:flutter/material.dart';
import 'package:players_app/functions/add_button_playlist.dart';
import 'package:players_app/functions/update_plylist_textfield.dart';
import 'package:players_app/screens/music/playlist/song_playlist_screen.dart';

void newPlaylistAdd(
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
                    ? addbuttonPressed(textediting, isSong, context)
                    : updateTextfieldDetails(
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