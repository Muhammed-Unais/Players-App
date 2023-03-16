import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/functions/songmodelcontrollers/playlistfunctions.dart';
import 'package:players_app/functions/videodbfunctions/videodbplaylist.dart';
import 'package:players_app/screens/music/playlist/added_playlistsongs.dart';
import 'package:players_app/screens/music/favorite_songs/songfavourite_listpage.dart';
import 'package:players_app/screens/music/playlist/song_playlist_screen.dart';
import 'package:players_app/screens/videos/playlist_video_screen.dart';
import 'package:players_app/screens/videos/video_favorite_screen.dart';
import 'package:players_app/screens/videos/videos_playlist_videos_list.dart';
import 'package:players_app/widgets/explore_widgets/explore_viewmore.dart';
import 'package:players_app/widgets/explore_widgets/favourites_cards.dart';
import 'package:players_app/widgets/explore_widgets/floating_action_button.dart';
import 'package:players_app/widgets/playlist_scree.dart/playlist_popup.dart';
import 'package:provider/provider.dart';

class FavouritesAndPlaylistScreen extends StatelessWidget {
  const FavouritesAndPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ============FloatingAction Buttonfor Explore Page Playlist Adding==========
      floatingActionButton: const SpeedDials(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              "Players App",
              style: GoogleFonts.raleway(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
          ),
        ),
      ),

      body: SafeArea(
        // ==========Explore Page Title Part=========
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==============Favorite Cards===========
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SongFavouriteScreen(),
                          ),
                        );
                      },
                      child: FavouritesCards(
                        firstIcon: Icons.favorite,
                        change: false,
                        height: MediaQuery.of(context).size.width / 2.5,
                        width: MediaQuery.of(context).size.height / 3.8,
                        image: "assets/images/pexels-pixabay-210766.jpg",
                        cardtext: "Songs",
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    // ================video Favorite Card================
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VideoFavoriteScreen(),
                          ),
                        );
                      },
                      child: FavouritesCards(
                          firstIcon: Icons.favorite,
                          change: false,
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.height / 3.8,
                          image:
                              "assets/images/pexels-dmitry-demidov-6764885.jpg",
                          cardtext: "Videos"),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // =====================view more button Song=============
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: ExploreViewmore(
                  fromSong: true,
                  viewmoreTitile: "Song Playlist",
                  viewMoreAction: () {
                    // ===============Navigating to All Playlist Page============
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SongPlaylistScreen(
                            playlistSongsShowornot: true,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              // =====================Song PlayList Part======================
              Expanded(
                // Currentlt playlist working========================================
                // ================================================================
                // ==============================================================
                child: Consumer<PlaylistDbSong>(
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
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              playlistDbSong.texteditngcontroller.length > 2
                                  ? 2
                                  : playlistDbSong.texteditngcontroller.length,
                          itemBuilder: (context, index) {
                            List test = playlistDbSong
                                .texteditngcontroller[index].songid;
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PlaylistSongsList(
                                          findex: index,
                                          playlist: playlistDbSong
                                              .texteditngcontroller[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: FavouritesCards(
                                  firstIcon: Icons.playlist_add_check_outlined,
                                  trailingicons: Icons.more_vert,
                                  change: true,
                                  cardtext: playlistDbSong
                                      .texteditngcontroller[index].name,
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  width: MediaQuery.of(context).size.width,
                                  image:
                                      "assets/images/pexels-pixabay-210766.jpg",

                                  // ==========Edit And Delete Dialouge Box And Function From Playlist Screen=========
                                  moreVertPopupicon: editAndDeleteDialoge(
                                    test: test,
                                    isforSong: true,
                                    ctx: context,
                                    index: index,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                }),
              ),
              // =====================view more button Video=============
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ExploreViewmore(
                  fromSong: false,
                  viewmoreTitile: "Video Playlist",
                  viewMoreAction: () {
                    // ===============Navigating to All Playlist Page============
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const VideoPlaylistScreen(
                            addedVideosShoworNot: true,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              // =====================Video PlayList Part======================
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: PlaylistVideoDb.videoPlaylistNotifier,
                  builder: (context, value, _) {
                    return value.isEmpty
                        ? const Center(
                            child: Text(
                              "Create Your Video Playlist",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.length > 2 ? 2 : value.length,
                            itemBuilder: (context, index) {
                              final editedVideosExisist = value[index].path;
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, right: 20),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return VideosPlaylistVideoList(
                                            findex: index,
                                            videoPlaylistFoldermodel:
                                                value[index],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: FavouritesCards(
                                    firstIcon:
                                        Icons.playlist_add_check_outlined,
                                    trailingicons: Icons.more_vert,
                                    change: true,
                                    cardtext: value[index].name,
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width: MediaQuery.of(context).size.width,
                                    image:
                                        "assets/images/pexels-dmitry-demidov-6764885.jpg",
                                    moreVertPopupicon:
                                        // ==========Edit And Delete Dialouge Box And Function From Playlist Screen=========
                                        editAndDeleteDialoge(
                                      test: editedVideosExisist,
                                      isforSong: false,
                                      ctx: context,
                                      index: index,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
