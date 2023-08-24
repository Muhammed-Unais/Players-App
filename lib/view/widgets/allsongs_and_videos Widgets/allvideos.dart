import 'package:flutter/material.dart';
import 'package:players_app/controllers/video_folder/access_folder/access_video.dart';
import 'package:players_app/controllers/video_folder/video_favorite_db.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/videos/play_screen/play_video_screen.dart';
import 'package:players_app/view/videos/playlist_videos/playlist_video_screen.dart';
import 'package:players_app/view/widgets/model_widget/listtale_songs_model.dart';
import 'package:players_app/view/widgets/thumbnail.dart';
import 'package:provider/provider.dart';

class AllVidoes extends StatelessWidget {
  const AllVidoes({super.key});

  @override
  Widget build(BuildContext context) {
    final videoFavDb = Provider.of<VideoFavoriteDb>(context);
    final videoFavDbs = Provider.of<VideoFavoriteDb>(context, listen: false);
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
          final vidPath = accessVideosPath[index];
          final vidTitle = accessVideosPath[index].toString().split('/').last;
          if (accessVideosPath.isEmpty) {
            return const Center(
              child: Text("No Videos Found"),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ListtaleModelVidSong(
              leading: thumbnail(path: vidPath, width: 100, hight: 100),
              title: accessVideosPath.isNotEmpty ? vidTitle : "No Videos",
              trailingOne: videoFavDb.isVideoFavor(
                PlayersVideoFavoriteModel(
                  title: vidTitle,
                  path: vidPath,
                ),
              )
                  ? IconButton(
                      onPressed: () {
                        videoFavDbs.delete(vidPath);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        videoFavDbs.add(
                          PlayersVideoFavoriteModel(
                            title: vidTitle,
                            path: vidPath,
                          ),
                        );
                      },
                      icon: const Icon(
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
