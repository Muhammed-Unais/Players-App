import 'package:flutter/material.dart';
import 'package:players_app/controllers/access_folder/access_video.dart';
import 'package:players_app/functions/videodbfunctions/video_favoritefunctions.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/screens/videos/play_video_screen.dart';
import 'package:players_app/screens/videos/playlist_video_screen.dart';
import 'package:players_app/widgets/models/listtale_songs_model.dart';
import 'package:players_app/widgets/thumbnail.dart';

class AllVidoes extends StatefulWidget {
  const AllVidoes({super.key});

  @override
  State<AllVidoes> createState() => _AllVidoesState();
}

class _AllVidoesState extends State<AllVidoes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
          ),
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: accessVideosPath.length,
        itemBuilder: (context, index) {
        if (accessVideosPath.isEmpty) {
          return const Center(
            child: Text("No Videos Found"),
          );
        }
          return Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: ListtaleModelVidSong(
              leading: thumbnail(path: accessVideosPath[index], choice: true),
              title: accessVideosPath.isNotEmpty
                  ? accessVideosPath[index].toString().split('/').last
                  : "No Videos",
              trailingOne: IconButton(
                onPressed: () {
                  setState(
                    () {
                      if (VideoFavoriteDb.isVideoFavor(
                        PlayersVideoFavoriteModel(
                            path: accessVideosPath[index],
                            title: accessVideosPath[index]
                                .toString()
                                .split('/')
                                .last),
                      )) {
                        VideoFavoriteDb.delete(accessVideosPath[index]);
                      } else {
                        VideoFavoriteDb.add(
                          PlayersVideoFavoriteModel(
                              path: accessVideosPath[index],
                              title: accessVideosPath[index]
                                  .toString()
                                  .split('/')
                                  .last),
                        );
                      }
                    },
                  );
    
                  VideoFavoriteDb.videoFavoriteDb.notifyListeners();
                },
                icon: VideoFavoriteDb.isVideoFavor(
                  PlayersVideoFavoriteModel(
                      path: accessVideosPath[index],
                      title: accessVideosPath[index].toString().split('/').last),
                )
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
              ),
              trailingTwo: PopupMenuButton(
                onSelected: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VideoPlaylistScreen(
                          vindex: index,
                          addedVideosShoworNot: false,
                        );
                      },
                    ),
                  );
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: const Text(
                      "Add PlayList",
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayVideoScreen(
                      isModelorPath: false,
                      paths: accessVideosPath,
                      index: index,
                    ),
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
