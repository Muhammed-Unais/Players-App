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
    final size = MediaQuery.of(context).size;

    return ListView.builder(
      padding: const EdgeInsets.only(right: 16, left: 16),
      shrinkWrap: true,
      itemCount: accessVideosPath.length,
      itemBuilder: (context, index) {
        final vidPath = accessVideosPath[index];
        final vidTitle = accessVideosPath[index].toString().split('/').last;
        if (accessVideosPath.isEmpty) {
          return Center(
            child: SizedBox(
              height: size.height * 0.4,
              width: size.width * 0.8,
              child: Image.asset("assets/images/Add files-rafiki.png"),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: ListtaleModelVidSong(
            leading: thumbnail(path: vidPath, width: 100, hight: 100),
            title: accessVideosPath.isNotEmpty ? vidTitle : "No Videos",
            trailingOne: Consumer<VideoFavoriteDb>(
              builder: (context, videoFavDbProvider, _) {
                if (videoFavDbProvider.isVideoFavor(PlayersVideoFavoriteModel(
                    title: vidTitle, path: vidPath))) {
                  return IconButton(
                    onPressed: () {
                      context.read<VideoFavoriteDb>().delete(vidPath);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                  );
                }
                return IconButton(
                  onPressed: () {
                    context.read<VideoFavoriteDb>().add(
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
                );
              },
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
                    paths: accessVideosPath,
                    index: index,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
