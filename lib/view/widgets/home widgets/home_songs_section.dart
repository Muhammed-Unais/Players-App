import 'package:flutter/material.dart';
import 'package:domedia/controllers/song_folder/recently_played_controller.dart';
import 'package:domedia/view/widgets/home%20widgets/home_song_list_tale.dart';
import 'package:provider/provider.dart';

class HomeSongSection extends StatefulWidget {
  const HomeSongSection({
    super.key,
  });

  @override
  State<HomeSongSection> createState() => HomeSongTileState();
}

class HomeSongTileState extends State<HomeSongSection> {
  @override
  void initState() {
    initializeRecentSongs();
    super.initState();
  }

  Future initializeRecentSongs() async {
    var recentSongsProvider = context.read<RecentlyPlayedSongsController>();
    if (!recentSongsProvider.isIntialize) {
      await context
          .read<RecentlyPlayedSongsController>()
          .initializRecentSongs();
    }
  }

  Future<void> refreshRecentSongs() async {
    var recentSongsProvider = context.read<RecentlyPlayedSongsController>();
    if (!recentSongsProvider.isIntialize) {
      await context
          .read<RecentlyPlayedSongsController>()
          .initializRecentSongs();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: Colors.black,
      onRefresh: refreshRecentSongs,
      child: Consumer<RecentlyPlayedSongsController>(
        builder: (context, recentSongProvider, _) {
          if (recentSongProvider.recentSongs.isEmpty) {
            return Center(
              child: SizedBox(
                height: size.height * 0.4,
                width: size.width * 0.8,
                child: Image.asset("assets/images/Music-rafiki.png"),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(right: 16, left: 16),
            physics: const AlwaysScrollableScrollPhysics(), 
            itemCount: recentSongProvider.recentSongs.length,
            itemBuilder: (context, index) {
              return SongsListTile(
                index: index,
                songModel: recentSongProvider.recentSongs,
              );
            },
          );
        },
      ),
    );
  }
}
