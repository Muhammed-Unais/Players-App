import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/access_folder/access_video.dart';
import 'package:players_app/controllers/functions/videodbfunctions/video_favoritefunctions.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/videos/play_video_screen.dart';
import 'package:players_app/view/widgets/models/listtale_songs_model.dart';
import 'package:players_app/view/widgets/thumbnail.dart';

class VideoFavoriteScreen extends StatefulWidget {
  const VideoFavoriteScreen({super.key});

  @override
  State<VideoFavoriteScreen> createState() => _VideoFavoriteScreenState();
}

class _VideoFavoriteScreenState extends State<VideoFavoriteScreen> {
  List allfavVideos = [];
  @override
  Widget build(BuildContext context) {
    if (!VideoFavoriteDb.isIntialized) {
      for (int i = 0; i < accessVideosPath.length; i++) {
        VideoFavoriteDb.intialize(PlayersVideoFavoriteModel(
            path: accessVideosPath[i],
            title: accessVideosPath[i].toString().split('/').last));
      }
    }
    return Scaffold(
      appBar: AppBar(
        title:  Text("Favorite Videos",style: GoogleFonts.raleway(
                fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
        valueListenable: VideoFavoriteDb.videoFavoriteDb,
        builder: (context, item, child) {
          return VideoFavoriteDb.videoFavoriteDb.value.isEmpty
              ? const Center(
                  child: Text(
                    "No Favorites",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListtaleModelVidSong(
                          leading:
                              thumbnail(path: item[index].path, choice: true),
                          title: item[index].title,
                          trailingOne: IconButton(
                            onPressed: () async {
                              setState(
                                () {
                                  if (VideoFavoriteDb.isVideoFavor(
                                    PlayersVideoFavoriteModel(
                                        path: item[index].path,
                                        title: item[index].title),
                                  )) {
                                    VideoFavoriteDb.delete(item[index].path);
                                  }
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayVideoScreen(
                                  paths: item,
                                  index: index,
                                  isModelorPath: true,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
