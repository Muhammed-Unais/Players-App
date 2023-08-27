import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/video_folder/videodbplaylist.dart';
import 'package:players_app/view/videos/playlist_videos/playlist_video_screen.dart';
import 'package:players_app/view/videos/playlist_videos/videos_playlist_videos_list.dart';
import 'package:players_app/view/widgets/explore_widgets/favourites_cards.dart';
import 'package:players_app/view/widgets/playlist_scree.dart/playlist_popup.dart';
import 'package:provider/provider.dart';

class ExploreVidoePlaylist extends StatelessWidget {
  const ExploreVidoePlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistVideoDb>(
      builder: (context, value, _) {
        return value.videoPlaylistNotifier.isEmpty
            ? const Center(
                child: Text(
                  "Create Your Video Playlist",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: value.videoPlaylistNotifier.length > 6
                    ? 6
                    : value.videoPlaylisdb.length,
                itemBuilder: (context, index) {
                  final editedVideosExisist =
                      value.videoPlaylistNotifier[index].path;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return index==5?  const VideoPlaylistScreen(
                            addedVideosShoworNot: true,
                          ):VideosPlaylistVideoList(
                              findex: index,
                              videoPlaylistFoldermodel:
                                  value.videoPlaylistNotifier[index],
                            );
                          },
                        ),
                      );
                    },
                    child: index == 5
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "View More",
                                style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        : FavouritesCards(
                            firstIcon: Icons.playlist_add_check_outlined,
                            trailingicons: Icons.more_vert,
                            change: true,
                            cardtext: value.videoPlaylistNotifier[index].name,
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width,
                            image:
                                "assets/images/pexels-dmitry-demidov-6764885.jpg",
                            moreVertPopupicon: editAndDeleteDialoge(
                              test: editedVideosExisist,
                              isforSong: false,
                              ctx: context,
                              index: index,
                            ),
                          ),
                  );
                },
              );
      },
    );
  }
}
