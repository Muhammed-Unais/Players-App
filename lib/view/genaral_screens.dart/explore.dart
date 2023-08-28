import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/view/music/favorite_songs/songfavourite_listpage.dart';
import 'package:players_app/view/videos/favorite_videos/video_favorite_screen.dart';
import 'package:players_app/view/widgets/explore_widgets/explore_video_playlist.dart';
import 'package:players_app/view/widgets/explore_widgets/favourite_explore_card.dart';
import 'package:players_app/view/widgets/explore_widgets/floating_action_button.dart';
import 'package:players_app/view/widgets/explore_widgets/songs_playlist_explore.dart';
import 'package:players_app/view/widgets/home%20widgets/home_circle_tab_indicator.dart';

class FavouritesAndPlaylistScreen extends StatefulWidget {
  const FavouritesAndPlaylistScreen({super.key});

  @override
  State<FavouritesAndPlaylistScreen> createState() =>
      _FavouritesAndPlaylistScreenState();
}

class _FavouritesAndPlaylistScreenState
    extends State<FavouritesAndPlaylistScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
     tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: const SpeedDials(),
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.4,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            "Explore",
            style: GoogleFonts.raleway(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: const FavouriteExploreCard(cardTitile: "Songs"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VideoFavoriteScreen(),
                        ),
                      );
                    },
                    child: const FavouriteExploreCard(cardTitile: "Vidoes"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey, thickness: 0.4),
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
                  Tab(text: "Songs playlist"),
                  Tab(text: "Video playlist"),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  SongsExplorePlaylist(),
                  ExploreVidoePlaylist(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
