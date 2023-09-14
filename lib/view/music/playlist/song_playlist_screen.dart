import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:domedia/controllers/song_and_video_playlistfolder/new_or_edit_playlist.dart';
import 'package:domedia/controllers/song_and_video_playlistfolder/song_addto_playlist.dart';
import 'package:domedia/controllers/song_folder/page_manager.dart';
import 'package:domedia/controllers/song_folder/playlist_db_song.dart';
import 'package:domedia/view/music/playlist/added_playlistsongs.dart';
import 'package:domedia/view/widgets/explore_widgets/favourites_cards.dart';
import 'package:domedia/view/widgets/playlist_scree.dart/playlist_popup.dart';
import 'package:provider/provider.dart';

GlobalKey<FormState> formkey = GlobalKey<FormState>();

class SongPlaylistScreen extends StatelessWidget {
  final int? findex;
  final bool playlistSongsShowornot;
  const SongPlaylistScreen({
    super.key,
    this.findex,
    required this.playlistSongsShowornot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
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
          NewOrEditPlaylist.newPlaylistAdd(
              isSong: true,
              isCreate: true,
              titile: "Create a Playlist",
              context: context);
        },
      ),
      body: Consumer<PlaylistDbSong>(
        builder: (context, musicplaylist, _) {
          return musicplaylist.texteditngcontroller.isEmpty
              ? Center(
                  child: Text(
                    "Create Your Playlist",
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 10, bottom: 10),
                  itemCount: musicplaylist.texteditngcontroller.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final datas = musicplaylist.texteditngcontroller[index];
                    final List<int> test = datas.songid;
                    return GestureDetector(
                      onTap: () {
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
                            : SongAddtoPlaylist.songAddToPlaylist(
                                PageManger.songscopy[findex!], datas, context);
                      },
                      child: FavouritesCards(
                        cardtext: datas.name,
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.width,
                        firstIcon: Icons.library_music_sharp,
                        trailingicons: Icons.more_vert,
                        moreVertPopupicon: editAndDeleteDialoge(
                          isforSong: true,
                          ctx: context,
                          index: index,
                          test: test,
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
