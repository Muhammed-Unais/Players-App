import 'package:flutter/material.dart';
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
    // final vidPlaylistAdd = Provider.of<VideoPlaylistAddDelete>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: ListTile(
              tileColor: Colors.white,
              contentPadding: const EdgeInsets.all(10),
              leading: thumbnail(path: accessVideosPath[index], choice: true),
              title: Text(
                accessVideosPath.isNotEmpty
                    ? accessVideosPath[index].toString().split('/').last
                    : "Not found your videos",
                style: GoogleFonts.roboto(
                    fontSize: 12, fontWeight: FontWeight.w500),
              ),
              trailing: Consumer<VideoPlaylistAddDelete>(
                builder: (context,videoPlaylistAddDb,_) {
                  return IconButton(
                    onPressed: () {
                      if (!videoPlaylistFoldermodel
                          .isValueIn(accessVideosPath[index])) {
                        videoPlaylistAddDb.add(
                            playersVideoPlaylistModel: videoPlaylistFoldermodel,
                            path: accessVideosPath[index]);
                      } else {
                        videoPlaylistAddDb.delete(
                            playersVideoPlaylistModel: videoPlaylistFoldermodel,
                            path: accessVideosPath[index]);
                      }
                    },
                    icon: !videoPlaylistFoldermodel.isValueIn(
                      accessVideosPath[index],
                    )
                        ? const Icon(Icons.add)
                        : const Icon(Icons.minimize),
                  );
                }
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
        itemCount: accessVideosPath.length,
      ),
    );
  }
}
