import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/functions/playlist_add_edit_delete.dart/new_playlist.dart';
import 'package:players_app/controllers/functions/playlist_add_edit_delete.dart/song_addto_playlist.dart';
import 'package:players_app/controllers/functions/songmodelcontrollers/playlistfunctions.dart';
import 'package:players_app/view/music/playlist/added_playlistsongs.dart';
import 'package:players_app/view/widgets/explore_widgets/favourites_cards.dart';
import 'package:players_app/view/widgets/home%20widgets/home_songs_section.dart';
import 'package:players_app/view/widgets/playlist_scree.dart/playlist_popup.dart';
import 'package:provider/provider.dart';

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
      body: 
      // ValueListenableBuilder(
      //   valueListenable: Hive.box<Playersmodel>('SongPlaylistDB').listenable(),
      Consumer<PlaylistDbSong>(
        builder: (context, musicplaylist, _) {
          return musicplaylist.texteditngcontroller.isEmpty
              ? Center(
                  child: Text(
                    "Create Your Playlist",
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                )
              : ListView.builder(
                  itemCount: musicplaylist.texteditngcontroller.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final datas = musicplaylist.texteditngcontroller[index];
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
                              : songAddToPlaylist(
                                  songmodel[findex!], datas, context);
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
                            test: test,
                          ),
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



// ==========Edit and Delete Dialoge Box================

// ===========Playlist Adding Dialougebox and DB adding Function============

// ==============Playlist Update Function ===============

// =============Playlist Add Button Pressed function==========



