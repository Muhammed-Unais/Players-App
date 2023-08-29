import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';
import 'package:players_app/controllers/video_folder/video_favorite_db.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/music/playing_screen/playing_music_page.dart';
import 'package:players_app/view/music/song_search.dart/controller/search_controller.dart';
import 'package:players_app/view/music/song_search.dart/widgets/search_listtale_leading.dart';
import 'package:players_app/view/music/song_search.dart/widgets/search_song_trailing.dart';
import 'package:players_app/view/videos/play_screen/play_video_screen.dart';
import 'package:players_app/view/videos/playlist_videos/playlist_video_screen.dart';
import 'package:provider/provider.dart';

class SongSearchScreen extends StatefulWidget {
  final bool isSong;
  const SongSearchScreen({super.key, required this.isSong});

  @override
  State<SongSearchScreen> createState() => _SongSearchScreenState();
}

class _SongSearchScreenState extends State<SongSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Consumer<SearchController>(
          builder: (context, searchController, _) {
            return TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(
                  IconlyBold.search,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => widget.isSong == true
                  ? searchController.searchsong(value)
                  : searchController.searchVideo(value, context),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Consumer<SearchController>(
          builder: (context, searchController, _) {
            if (searchController.foundVideos.isEmpty && !widget.isSong) {
              return Center(
                child: SizedBox(
                  height: size.height * 0.4,
                  width: size.width * 0.8,
                  child: Image.asset("assets/images/Curious-rafiki.png"),
                ),
              );
            }
            if (searchController.foundSongs.isEmpty && widget.isSong) {
              return Center(
                child: SizedBox(
                  height: size.height * 0.4,
                  width: size.width * 0.8,
                  child: Image.asset("assets/images/Curious-rafiki.png"),
                ),
              );
            }
            return ListView.builder(
              itemCount: widget.isSong
                  ? searchController.foundSongs.length
                  : searchController.foundVideos.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var vidPath = '';
                var vidTitle = '';
                var foundSong = SongModel({});
                if (!widget.isSong) {
                  vidPath = searchController.foundVideos[index];
                  vidTitle = searchController.foundVideos[index]
                      .toString()
                      .split('/')
                      .last;
                } else {
                  foundSong = searchController.foundSongs[index];
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: ListTile(
                    onTap: widget.isSong
                        ? () {
                            PageManger.audioPlayer.setAudioSource(
                                PageManger.songListCreating(
                                  searchController.foundSongs,
                                ),
                                initialIndex: index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PlayingMusicScreen(
                                    index: index,
                                    songModelList: searchController.foundSongs,
                                  );
                                },
                              ),
                            );
                          }
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayVideoScreen(
                                  paths: searchController.foundVideos,
                                  index: index,
                                ),
                              ),
                            );
                          },
                    title: widget.isSong
                        ? Text(
                            overflow: TextOverflow.ellipsis,
                            foundSong.title,
                            style: GoogleFonts.raleway(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                          )
                        : Text(
                            vidTitle,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.raleway(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                          ),
                    subtitle: widget.isSong
                        ? Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            foundSong.artist == null ||
                                    foundSong.artist == "<unknown>"
                                ? "Unknown Artist"
                                : foundSong.artist!,
                            style: GoogleFonts.raleway(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          )
                        : null,
                    leading: SearchLeading(
                      isSong: widget.isSong,
                      songModel: foundSong,
                      videoModel: vidPath,
                    ),
                    trailing: widget.isSong
                        ? SongTrailing(
                            index: index,
                            songModel: foundSong,
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Consumer<VideoFavoriteDb>(
                                builder: (context, vidFavProvider, _) {
                                  return IconButton(
                                    onPressed: () =>
                                        vidFavProvider.favouriteAddandDelete(
                                            path: vidPath, title: vidTitle),
                                    icon: vidFavProvider.isVideoFavor(
                                      PlayersVideoFavoriteModel(
                                          path: vidPath, title: vidTitle),
                                    )
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.black,
                                          )
                                        : const Icon(
                                            Icons.favorite_border,
                                            color: Colors.black,
                                          ),
                                  );
                                },
                              ),
                              PopupMenuButton(
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
                            ],
                          ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
