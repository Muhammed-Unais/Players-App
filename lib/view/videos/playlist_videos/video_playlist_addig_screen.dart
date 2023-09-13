import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/video_folder/access_folder/access_video.dart';
import 'package:players_app/view/videos/playlist_videos/controller/playlist_add_delete.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/widgets/thumbnail.dart';
import 'package:provider/provider.dart';

class VideoaddtoPlaylistfrmAllVideo extends StatelessWidget {
  final PlayersVideoPlaylistModel videoPlaylistFoldermodel;
  const VideoaddtoPlaylistfrmAllVideo(
      {super.key, required this.videoPlaylistFoldermodel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer<VideoFileAccessFromStorage>(
          builder: (context, videoProvider, _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: ListTile(
                tileColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
                leading: thumbnail(
                    path: videoProvider.accessVideosPath[index],
                    hight: 100,
                    width: 100),
                title: Text(
                  videoProvider.accessVideosPath.isNotEmpty
                      ? videoProvider.accessVideosPath[index]
                          .toString()
                          .split('/')
                          .last
                      : "Not found your videos",
                  style: GoogleFonts.roboto(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                trailing: Consumer<VideoPlaylistAddDelete>(
                    builder: (context, videoPlaylistAddDb, _) {
                  return IconButton(
                    onPressed: () {
                      if (!videoPlaylistFoldermodel
                          .isValueIn(videoProvider.accessVideosPath[index])) {
                        videoPlaylistAddDb.add(
                            playersVideoPlaylistModel: videoPlaylistFoldermodel,
                            path: videoProvider.accessVideosPath[index]);
                      } else {
                        videoPlaylistAddDb.delete(
                            playersVideoPlaylistModel: videoPlaylistFoldermodel,
                            path: videoProvider.accessVideosPath[index]);
                      }
                    },
                    icon: !videoPlaylistFoldermodel.isValueIn(
                      videoProvider.accessVideosPath[index],
                    )
                        ? const Icon(Icons.add)
                        : const Icon(Icons.minimize),
                  );
                }),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
          itemCount: videoProvider.accessVideosPath.length,
        );
      }),
    );
  }
}
