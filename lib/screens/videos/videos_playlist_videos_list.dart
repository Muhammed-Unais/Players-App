import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:players_app/controllers/access_folder/access_video.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/screens/videos/play_video_screen.dart';
import 'package:players_app/screens/videos/video_playlist_addig_screen.dart';
import 'package:players_app/widgets/models/listtale_songs_model.dart';
import 'package:players_app/widgets/thumbnail.dart';

class VideosPlaylistVideoList extends StatelessWidget {
  final int findex;
  final PlayersVideoPlaylistModel videoPlaylistFoldermodel;
  const VideosPlaylistVideoList(
      {super.key,
      required this.findex,
      required this.videoPlaylistFoldermodel});

  @override
  Widget build(BuildContext context) {
    List videosinPlaylistFolder = [];
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
        title: Text(videoPlaylistFoldermodel.name,style: GoogleFonts.raleway(
                fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),),
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
                            path: videosinPlaylistFolder[index], choice: true),
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
                                isModelorPath: false,
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

  listVideoPlayList(List dates) {
    List tempvideosPath = [];

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
