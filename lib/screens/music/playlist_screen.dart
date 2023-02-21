import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/functions/songmodelcontrollers/playlistfunctions.dart';
import 'package:players_app/functions/videodbfunctions/videodbplaylist.dart';
import 'package:players_app/model/db/dbmodel.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/screens/music/added_playlistsongs.dart';
import 'package:players_app/widgets/explore_widgets/favourites_cards.dart';
import 'package:players_app/widgets/home%20widgets/home_songs_section.dart';

GlobalKey<FormState> formkey = GlobalKey<FormState>();

class SongPlaylistScreen extends StatelessWidget {
  // final SongModel? addtoPlaylist;

  // ================This the Song Playlist screen and Navigate from allsongs and explore view more page=================
  final int? findex;
  // this bool value for navigate to added song page or not explore viewmore navigate and allsongs page didnot navigate
  final bool playlistSongsShowornot;
  const SongPlaylistScreen({
    super.key,
    // this.addtoPlaylist,
    this.findex,
    required this.playlistSongsShowornot,
  });

  // =============PlaylistFolders ShowingScreen=========
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Songs Playlists",
          style: GoogleFonts.raleway(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.playlist_add),
        onPressed: () {
          // ===========Playlist Adding Dialougebox and DB adding Function==========
          newPlaylistAdd(
              isSong: true,
              isCreate: true,
              titile: "Create a Playlist",
              context: context);
        },
      ),
      // ============Value listanble Builder From PlaylistDBSong=========
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Playersmodel>('SongPlaylistDB').listenable(),
        builder: (context, musicplaylist, _) {
          return musicplaylist.isEmpty
              ? Center(
                  child: Text(
                    "Create Your Playlist",
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ) :ListView.builder(
            itemCount: musicplaylist.length,
            itemBuilder: (
              context,
              index,
            ) {
              final datas = musicplaylist.values.toList()[index];
              final List<int> test = datas.songid;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // ==============Add Songs To Playlist folder==============

                    playlistSongsShowornot == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PlaylistSongsList(
                                  playlist: datas,
                                  findex: index,
                                );
                              },
                            ),
                          )
                        : songAddToPlaylist(songmodel[findex!], datas, context);
                  },
                  child: FavouritesCards(
                    cardtext: datas.name,
                    change: true,
                    height: MediaQuery.of(context).size.height / 10,
                    width: MediaQuery.of(context).size.width,
                    image: "assets/images/pexels-pixabay-210766.jpg",
                    firstIcon: Icons.playlist_add_check_outlined,
                    trailingicons: Icons.more_vert,
                    moreVertPopupicon: editAndDeleteDialoge(
                        isforSong: true,
                        ctx: context,
                        index: index,
                        test: test),
                    //==========Edit and Delete Dialoge Box================
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void songAddToPlaylist(SongModel song, Playersmodel datas, context) {
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

// ==========Edit and Delete Dialoge Box================
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

showDialougeForDelete(context, isForSong, index) {
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
                  ? PlaylistDbSong.deletePlaylist(index)
                  : PlaylistVideoDb.deleteVideoPlaylist(index);
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

// ===========Playlist Adding Dialougebox and DB adding Function============
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

// ==============Playlist Update Function ===============
updateTextfieldDetails(
    String textediting, int index, bool isSong, test, context) {
  final updatedText = textediting.trim();
  if (updatedText.isEmpty) {
    return;
  }
  if (isSong == true) {
    if (PlaylistDbSong.checkSameName(
        Playersmodel(name: updatedText, songid: test))) {
      Snackbars.snackBar(context, "Playlist Already Exist");
    } else {
      PlaylistDbSong.editPlaylist(
          Playersmodel(name: updatedText, songid: test), index);
      Snackbars.snackBar(context, "Playlist Edited Successfully");
    }
  } else {
    if (PlaylistVideoDb.checkSameName(
      PlayersVideoPlaylistModel(name: updatedText, path: test),
    )) {
      Snackbars.snackBar(context, "Playlist Already Exist");
    }else{
       PlaylistVideoDb.updateVideoPlaylist(
      index,
      PlayersVideoPlaylistModel(name: updatedText, path: test),
    );
    Snackbars.snackBar(context, "Playlist Edited Successfully");
    }
  }
  Navigator.pop(context);
}

// =============Playlist Add Button Pressed function==========
addbuttonPressed(String textediting, bool isSong, context) {
  final text = textediting.trim();
  if (text.isEmpty) {
    return;
  }
  if (isSong == true) {
    if (PlaylistDbSong.checkSameName(
      Playersmodel(
        name: text,
        songid: [],
      ),
    )) {
      Snackbars.snackBar(context, "Playlist Already Exist");
    } else {
      PlaylistDbSong.add(
        Playersmodel(
          name: text,
          songid: [],
        ),
      );
      Snackbars.snackBar(context, "Playlist Created Successfully");
    }
  } else {
    if (PlaylistVideoDb.checkSameName(
      PlayersVideoPlaylistModel(
        name: text,
        path: [],
      ),
    )) {
      Snackbars.snackBar(context, "Playlist Already Exist");
    } else {
      PlaylistVideoDb.add(
        PlayersVideoPlaylistModel(
          name: text,
          path: [],
        ),
      );
      Snackbars.snackBar(context, "Playlist Created Successfully");
    }
  }
  Navigator.pop(context);
}

class Snackbars {
  static snackBar(context, String content) {
    final snackbar = SnackBar(
      duration: const Duration(milliseconds: 950),
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
