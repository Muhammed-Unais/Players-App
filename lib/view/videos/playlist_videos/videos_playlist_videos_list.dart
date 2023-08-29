import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:players_app/controllers/song_and_video_playlistfolder/alert_dialotgue_songs_video_delete.dart';
import 'package:players_app/controllers/video_folder/access_folder/access_video.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/videos/play_screen/play_video_screen.dart';
import 'package:players_app/view/videos/playlist_videos/video_playlist_addig_screen.dart';
import 'package:players_app/view/widgets/model_widget/listtale_songs_model.dart';
import 'package:players_app/view/widgets/thumbnail.dart';
import 'package:provider/provider.dart';

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
              listVideoPlayList(videos.values.toList()[findex].path, context);
          final test = videos.values.toList()[findex];
          return videosinPlaylistFolder.isEmpty
              ? Center(
                  child: Text(
                    "Add your playlist",
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: videosinPlaylistFolder.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
                      child: ListtaleModelVidSong(
                        leading: thumbnail(
                            path: videosinPlaylistFolder[index],
                            width: 100,
                            hight: 100),
                        title: videosinPlaylistFolder[index]
                            .toString()
                            .split('/')
                            .last,
                        trailingOne: IconButton(
                          onPressed: () {
                            deleteVideoAndSongs(context, "Delete", () {
                              test.deleteData(videosinPlaylistFolder[index]);
                              Navigator.pop(context);
                            });
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

  List<String> listVideoPlayList(List<String> dates, BuildContext context) {
    List<String> tempvideosPath = [];

    var accessVideosPath =
        context.read<VideoFileAccessFromStorage>().accessVideosPath;

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
