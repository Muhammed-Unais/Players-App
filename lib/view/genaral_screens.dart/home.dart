import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/song_folder/playlist_db_song.dart';
import 'package:players_app/controllers/video_folder/videodbplaylist.dart';
import 'package:players_app/view/genaral_screens.dart/all_songs_and_videos.dart';
import 'package:players_app/view/music/playlist/song_playlist_screen.dart';
import 'package:players_app/view/music/favorite_songs/songfavourite_listpage.dart';
import 'package:players_app/view/videos/playlist_videos/playlist_video_screen.dart';
import 'package:players_app/view/videos/favorite_videos/video_favorite_screen.dart';
import 'package:players_app/view/widgets/home%20widgets/home_appbar.dart';
import 'package:players_app/view/widgets/home%20widgets/home_songs_section.dart';
import 'package:players_app/view/widgets/home%20widgets/home_video.dart';
import 'package:players_app/view/widgets/home%20widgets/home_viewmore.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List items = [
    "Songs Favorite",
    "Video Favorite",
    "Songs Playlist",
    "Video Playlist",
  ];

  List<Widget> icons = [
    const Icon(Icons.favorite_border, size: 16, color: Colors.white),
    const Icon(Icons.favorite_border, size: 16, color: Colors.white),
    const Icon(Icons.playlist_play_outlined, size: 16, color: Colors.white),
    const Icon(Icons.playlist_play_outlined, size: 16, color: Colors.white)
  ];

  List<Widget> navigateScreen = [
    const SongFavouriteScreen(),
    const VideoFavoriteScreen(),
    const SongPlaylistScreen(playlistSongsShowornot: true),
    const VideoPlaylistScreen(
      addedVideosShoworNot: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Provider.of<PlaylistDbSong>(context,listen: false).getAllPlaylists();
    Provider.of<PlaylistVideoDb>(context,listen: false).getAllPlaylistVideos();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const HomeAppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            height: hight * 0.125,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return navigateScreen[index];
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 36,
                      width: width / 100 * 40,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withAlpha(80),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            items[index],
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white70),
                          ),
                          icons[index]
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ListView(
                  children: [
                    HomeViewmore(
                      homeViewmoreTitile: "Songs",
                      homeViewMoreAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllSongsAndVideosScreen(
                                recheck: false, index: 0),
                          ),
                        );
                      },
                    ),
                    const HomeSongSection(),
                    const SizedBox(height: 13),
                    HomeViewmore(
                      homeViewMoreAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllSongsAndVideosScreen(
                              recheck: true,
                              index: 1,
                            ),
                          ),
                        );
                      },
                      homeViewmoreTitile: 'Videos',
                    ),
                    const HomeVideoScreen(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
