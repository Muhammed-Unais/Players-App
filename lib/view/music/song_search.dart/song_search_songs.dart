import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/video_folder/access_folder/access_video.dart';
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
  OnAudioQuery onAudioQuery = OnAudioQuery();
  AudioPlayer audioPlayer = AudioPlayer();
  List<String> foundVideos = [];
  late List<String> allVideos;
  @override
  void initState() {
    videoLoading();
    setState(() {});
    super.initState();
  }

  videoLoading() {
    allVideos = accessVideosPath;
    foundVideos.addAll(allVideos);
  }

  searchVideo(String enteredKeyWords) {
    List<String> result = [];
    if (enteredKeyWords.isEmpty) {
      result = allVideos;
    } else {
      result = allVideos
          .where((element) => element
              .toString()
              .split('/')
              .last
              .toLowerCase()
              .contains(enteredKeyWords.toLowerCase()))
          .toList();
    }
    setState(() {
      foundVideos = result;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final searchCntrl = Provider.of<SearchController>(context);
    final vidFavProvider=Provider.of<VideoFavoriteDb>(context);
    searchCntrl.songLoading();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        // ===============TextField================
        title: Consumer<SearchController>(builder: (context, values, _) {
          return TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(fontSize: 20),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => widget.isSong == true
                ? values.searchsong(value)
                : searchVideo(value),
          );
        }),
      ),

      // ====================SafeArea====================
      body: SafeArea(
        child: searchCntrl.foundSongs.isNotEmpty && foundVideos.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: searchCntrl.foundSongs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final vidPath = foundVideos[index];
                  final vidTitle =
                      foundVideos[index].toString().split('/').last;
                  return ListTile(
                    onTap: widget.isSong == true
                        ? () {
                            PageManger.audioPlayer.setAudioSource(
                                PageManger.songListCreating(
                                  searchCntrl.foundSongs,
                                ),
                                initialIndex: index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PlayingMusicScreen(
                                    index: index,
                                    songModelList: searchCntrl.foundSongs,
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
                                 
                                  paths: foundVideos,
                                  index: index,
                                ),
                              ),
                            );
                          },

                    // ==================title===================
                    title: widget.isSong == true
                        ? Text(searchCntrl.foundSongs[index].title,
                            overflow: TextOverflow.ellipsis)
                        : Text(vidTitle, overflow: TextOverflow.ellipsis),
                    // ==================Subtitle===================
                    subtitle: widget.isSong == true
                        ? Text(searchCntrl.foundSongs[index].artist == null ||
                                searchCntrl.foundSongs[index].artist ==
                                    "<unknown>"
                            ? "Unknown Artist"
                            : searchCntrl.foundSongs[index].artist!)
                        : const Text(''),

                    // =================Leading======================

                    leading: SearchLeading(
                      isSong: widget.isSong,
                      songModel: searchCntrl.foundSongs[index],
                      videoModel: vidPath,
                    ),
                    // ==================Trailing=====================
                    trailing: widget.isSong == true
                        ?
                        // =====================SONGS TRAILNGS===================
                        SongTrailing(
                            index: index,
                            songModel: searchCntrl.foundSongs[index],
                          )
                        :
                        // =====================ViDEO TRAILINGS===================
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    vidFavProvider.favouriteAddandDelete(
                                        path: vidPath,
                                        title: vidTitle),
                                icon: vidFavProvider.isVideoFavor(
                                  PlayersVideoFavoriteModel(
                                    path: vidPath,
                                    title: vidTitle
                                  ),
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
                  );
                },
              )
            : Center(
                child: Text(
                  widget.isSong == true
                      ? 'Songs not found'
                      : "Videos not found",
                ),
              ),
      ),
    );
  }
}
