import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/recently_played_controller.dart';
import 'package:players_app/view/widgets/home%20widgets/home_song_list_tale.dart';
import 'package:provider/provider.dart';

List<SongModel> songmodel = [];

class HomeSongSection extends StatefulWidget {
  const HomeSongSection({super.key});

  @override
  State<HomeSongSection> createState() => HomeSongTileState();
}

class HomeSongTileState extends State<HomeSongSection> {
  
  @override
  void initState() {
    initializeRecentSongs();
    super.initState();
  }

  void initializeRecentSongs() {
    var recentSongsProvider = context.read<RecentlyPlayedSongsController>();
    if (!recentSongsProvider.isIntialize) {
      context.read<RecentlyPlayedSongsController>().initializRecentSongs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Consumer<RecentlyPlayedSongsController>(
          builder: (context, recentSongsProvider, _) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recentSongsProvider.recentSongs.length,
              itemBuilder: (context, index) {
                return SongsListTile(
                  index: index,
                  songModel: recentSongsProvider.recentSongs,
                );
              },
            );
          },
        )
      ],
    );
  }
}
