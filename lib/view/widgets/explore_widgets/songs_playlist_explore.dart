import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/song_folder/playlist_db_song.dart';
import 'package:players_app/view/music/playlist/added_playlistsongs.dart';
import 'package:players_app/view/music/playlist/song_playlist_screen.dart';
import 'package:players_app/view/widgets/explore_widgets/favourites_cards.dart';
import 'package:players_app/view/widgets/playlist_scree.dart/playlist_popup.dart';
import 'package:provider/provider.dart';

class SongsExplorePlaylist extends StatelessWidget {
  const SongsExplorePlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistDbSong>(
      builder: (context, playlistDbSong, __) {
        playlistDbSong.getAllPlaylists();
        return playlistDbSong.texteditngcontroller.isEmpty
            ? const Center(
                child: Text(
                  "Create Your Songs Playlist",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: playlistDbSong.texteditngcontroller.length > 6
                    ? 6
                    : playlistDbSong.texteditngcontroller.length,
                itemBuilder: (context, index) {
                  var test = playlistDbSong.texteditngcontroller[index].songid;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return index == 5
                                ? const SongPlaylistScreen(
                                    playlistSongsShowornot: true,
                                  )
                                : PlaylistSongsList(
                                    findex: index,
                                    playlist: playlistDbSong
                                        .texteditngcontroller[index],
                                  );
                          },
                        ),
                      );
                    },
                    child: index == 5
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "View More",
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        : FavouritesCards(
                            firstIcon: Icons.playlist_add_check_outlined,
                            trailingicons: Icons.more_vert,
                            change: true,
                            cardtext:
                                playlistDbSong.texteditngcontroller[index].name,
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width,
                            image: "assets/images/pexels-pixabay-210766.jpg",
                            moreVertPopupicon: editAndDeleteDialoge(
                              test: test,
                              isforSong: true,
                              ctx: context,
                              index: index,
                            ),
                          ),
                  );
                },
              );
      },
    );
  }
}
