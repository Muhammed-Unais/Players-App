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
    final size = MediaQuery.of(context).size;
    return Consumer<PlaylistVideoDb>(
      builder: (context, value, _) {
        return value.videoPlaylistNotifier.isEmpty
            ?  Center(
              child: SizedBox(
                height: size.height*0.4,
                width: size.width*0.8,
                child: Image.asset("assets/images/Add files-rafiki.png"),
              ),
            )
            : ListView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16),
                itemCount: value.videoPlaylistNotifier.length > 6
                    ? 6
                    : value.videoPlaylisdb.length,
                itemBuilder: (context, index) {
                  var editedVideosExisist =
                      value.videoPlaylistNotifier[index].path;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return index == 5
                                ? const VideoPlaylistScreen(
                                    addedVideosShoworNot: true,
                                  )
                                : VideosPlaylistVideoList(
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
                            height: size.height / 10,
                            width: size.width,
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
                            firstIcon: Icons.video_collection_sharp,
                            trailingicons: Icons.more_vert,
                            cardtext: value.videoPlaylistNotifier[index].name,
                            height: size.height * 0.095,
                            width: size.width,
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
