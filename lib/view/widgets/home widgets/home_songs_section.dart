import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/recently_played_controller.dart';
import 'package:players_app/view/widgets/home%20widgets/home_song_list_tale.dart';
import 'package:provider/provider.dart';

List<SongModel> songmodel = [];

class HomeSongSection extends StatefulWidget {
  const HomeSongSection({super.key, required this.recentSongsProvider});

  final RecentlyPlayedSongsController recentSongsProvider;

  @override
  State<HomeSongSection> createState() => HomeSongTileState();
}

class HomeSongTileState extends State<HomeSongSection> {
 

  Future<void> initializeRecentSongs() async {
    RecentlyPlayedSongsController recentSongsProvider =
        context.read<RecentlyPlayedSongsController>();
    if (!recentSongsProvider.isIntialize) {
      await context
          .read<RecentlyPlayedSongsController>()
          .initializRecentSongs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black,
      onRefresh: initializeRecentSongs,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.recentSongsProvider.recentSongs.length,
        itemBuilder: (context, index) {
          return SongsListTile(
            index: index,
            songModel: widget.recentSongsProvider.recentSongs,
          );
        },
      ),
    );
  }
}
