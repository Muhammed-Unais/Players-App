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
    final size = MediaQuery.of(context).size;
    return Consumer<PlaylistDbSong>(
      builder: (context, playlistDbSong, __) {
        return playlistDbSong.texteditngcontroller.isEmpty
            ? Center(
              child: SizedBox(
                height: size.height*0.4,
                width: size.width*0.8,
                child: Image.asset("assets/images/Add files-rafiki.png"),
              ),
            )
            : ListView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16),
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
                            height: size.height / 10,
                            width: size.width,
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
                            firstIcon: Icons.library_music,
                            trailingicons: Icons.more_vert,
                            cardtext:
                                playlistDbSong.texteditngcontroller[index].name,
                            height: size.height * 0.095,
                            width: size.width,
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
