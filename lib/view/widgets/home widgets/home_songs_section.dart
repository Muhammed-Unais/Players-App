import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/recently_played_controller.dart';
import 'package:players_app/view/widgets/home%20widgets/home_song_list_tale.dart';
import 'package:provider/provider.dart';

class HomeSongSection extends StatefulWidget {
  const HomeSongSection({
    super.key,
  });

  @override
  State<HomeSongSection> createState() => HomeSongTileState();
}

class HomeSongTileState extends State<HomeSongSection> {
  List<SongModel> _recentsongs = [];

  Future<List<SongModel>> initializeRecentSongs() async {
    var recentSongsProvider = context.read<RecentlyPlayedSongsController>();
    if (!recentSongsProvider.isIntialize) {
     _recentsongs= await context
          .read<RecentlyPlayedSongsController>()
          .initializRecentSongs();
      return _recentsongs;
    }
    return recentSongsProvider.recentSongs;
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
      child: FutureBuilder<List<SongModel>>(
        future: initializeRecentSongs(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (snapShot.connectionState == ConnectionState.done &&
              snapShot.data!.isEmpty) {
            return Center(
              child: SizedBox(
                height: size.height*0.4,
                width: size.width*0.8,
                child: Image.asset("assets/images/Music-rafiki.png"),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(right: 16, left: 16),
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapShot.data?.length,
            itemBuilder: (context, index) {
              return SongsListTile(
                index: index,
                songModel: snapShot.data!,
              );
            },
          );
        },
      ),
    );
  }
}
