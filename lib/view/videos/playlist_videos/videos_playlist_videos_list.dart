import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:players_app/controllers/video_folder/access_folder/access_video.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/videos/play_screen/play_video_screen.dart';
import 'package:players_app/view/videos/playlist_videos/video_playlist_addig_screen.dart';
import 'package:players_app/view/widgets/model_widget/listtale_songs_model.dart';
import 'package:players_app/view/widgets/thumbnail.dart';

class VideosPlaylistVideoList extends StatelessWidget {
  final int findex;
  final PlayersVideoPlaylistModel videoPlaylistFoldermodel;
  const VideosPlaylistVideoList(
      {super.key,
      required this.findex,
      required this.videoPlaylistFoldermodel});

  @override
  Widget build(BuildContext context) {
    List<String> videosinPlaylistFolder = [];
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add Videos"),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return VideoaddtoPlaylistfrmAllVideo(
                  videoPlaylistFoldermodel: videoPlaylistFoldermodel,
                );
              },
            ),
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          videoPlaylistFoldermodel.name,
          style: GoogleFonts.raleway(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<PlayersVideoPlaylistModel>('VideoplaylistDB').listenable(),
        builder: (context, videos, _) {
          videosinPlaylistFolder =
              listVideoPlayList(videos.values.toList()[findex].path);
          final test = videos.values.toList()[findex];
          return videosinPlaylistFolder.isEmpty
              ? const Center(
                  child: Text(
                    "Add Your Playlist",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: videosinPlaylistFolder.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListtaleModelVidSong(
                        leading: thumbnail(
                            path: videosinPlaylistFolder[index],
                            width: double.infinity,
                            hight: double.infinity),
                        title: videosinPlaylistFolder[index]
                            .toString()
                            .split('/')
                            .last,
                        trailingOne: IconButton(
                          onPressed: () {
                            test.deleteData(videosinPlaylistFolder[index]);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayVideoScreen(
                                paths: videosinPlaylistFolder,
                                index: index,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

 List<String> listVideoPlayList(List dates) {
    List<String> tempvideosPath = [];

    for (var i = 0; i < accessVideosPath.length; i++) {
      for (var j = 0; j < dates.length; j++) {
        if (accessVideosPath[i] == dates[j]) {
          tempvideosPath.add(accessVideosPath[i]);
        }
      }
    }
    return tempvideosPath;
  }
}
