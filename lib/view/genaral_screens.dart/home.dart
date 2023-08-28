import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:players_app/controllers/song_folder/playlist_db_song.dart';
import 'package:players_app/controllers/video_folder/videodbplaylist.dart';
import 'package:players_app/view/music/playlist/song_playlist_screen.dart';
import 'package:players_app/view/music/favorite_songs/songfavourite_listpage.dart';
import 'package:players_app/view/videos/playlist_videos/playlist_video_screen.dart';
import 'package:players_app/view/videos/favorite_videos/video_favorite_screen.dart';
import 'package:players_app/view/widgets/home%20widgets/home_appbar.dart';
import 'package:players_app/view/widgets/home%20widgets/home_circle_tab_indicator.dart';
import 'package:players_app/view/widgets/home%20widgets/home_favourite_playlist_button.dart';
import 'package:players_app/view/widgets/home%20widgets/home_songs_section.dart';
import 'package:provider/provider.dart';
import '../widgets/home widgets/home_video.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List items = [
    "Songs Favorites",
    "Video Favorites",
    "Songs Playlists",
    "Video Playlists"
  ];

  List<Widget> icons = [
    const Icon(Icons.favorite_outlined, size: 16, color: Colors.black),
    const Icon(Icons.favorite, size: 16, color: Colors.black),
    const Icon(Icons.playlist_play_outlined, size: 16, color: Colors.black),
    const Icon(Icons.playlist_play_outlined, size: 16, color: Colors.black)
  ];

  List<Widget> navigateScreen = [
    const SongFavouriteScreen(),
    const VideoFavoriteScreen(),
    const SongPlaylistScreen(playlistSongsShowornot: true),
    const VideoPlaylistScreen(
      addedVideosShoworNot: true,
    )
  ];

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    context.read<PlaylistDbSong>().getAllPlaylists();
    context.read<PlaylistVideoDb>().getAllPlaylistVideos();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HomeAppBar(),
      body: Column(
        children: [
          FavouriteAndPlaylistButton(
            hight: hight,
            navigateScreen: navigateScreen,
            width: width,
            items: items,
            icons: icons,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              padding: const EdgeInsets.only(left: 16),
              isScrollable: true,
              labelPadding: const EdgeInsets.only(left: 4, right: 16),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              labelStyle: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              controller: tabController,
              indicator:
                  const CircleTabIndicator(color: Colors.black, radius: 3),
              tabs: const [
                Tab(text: "Recent songs"),
                Tab(text: "Recent videos"),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 500,
                        width: 500,
                        child: Lottie.asset("assets/images/homesong.json",
                            animate: true),
                      ),
                    ),
                    const HomeSongSection(),
                  ],
                ),
                const HomeVideoScreen()
              ],
            ),
          )
        ],
      ),
    );
  }
}
