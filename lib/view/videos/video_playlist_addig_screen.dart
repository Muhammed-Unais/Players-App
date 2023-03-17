import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/access_folder/access_video.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/widgets/thumbnail.dart';

class VideoaddtoPlaylistfrmAllVideo extends StatefulWidget {
  final PlayersVideoPlaylistModel videoPlaylistFoldermodel;
  const VideoaddtoPlaylistfrmAllVideo(
      {super.key, required this.videoPlaylistFoldermodel});

  @override
  State<VideoaddtoPlaylistfrmAllVideo> createState() =>
      _VideoaddtoPlaylistfrmAllVideoState();
}

class _VideoaddtoPlaylistfrmAllVideoState
    extends State<VideoaddtoPlaylistfrmAllVideo> {
  @override
  Widget build(BuildContext context) {
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
              trailing: IconButton(
                onPressed: () {
                  setState(
                    () {
                      if (!widget.videoPlaylistFoldermodel
                          .isValueIn(accessVideosPath[index])) {
                        videosAddtoPlaylist(accessVideosPath[index]);
                      } else {
                        widget.videoPlaylistFoldermodel
                            .deleteData(accessVideosPath[index]);
                      }
                    },
                  );
                },
                icon: !widget.videoPlaylistFoldermodel.isValueIn(
                  accessVideosPath[index],
                )
                    ? const Icon(Icons.add)
                    : const Icon(Icons.minimize),
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

  void videosAddtoPlaylist(String paths) {
    widget.videoPlaylistFoldermodel.add(paths);
    const snackbar1 = SnackBar(
      duration: Duration(milliseconds: 650),
      backgroundColor: Colors.black,
      content: Text(
        'Video added to Playlist',
        style: TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar1);
  }
}
