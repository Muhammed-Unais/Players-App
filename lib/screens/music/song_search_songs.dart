import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/access_folder/access_video.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/functions/songmodelcontrollers/favouritedbfunctions.dart';
import 'package:players_app/functions/videodbfunctions/video_favoritefunctions.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/screens/music/playing_music_page.dart';
import 'package:players_app/screens/music/playlist_screen.dart';
import 'package:players_app/screens/videos/play_video_screen.dart';
import 'package:players_app/screens/videos/playlist_video_screen.dart';
import 'package:players_app/widgets/thumbnail.dart';

class SongSearchScreen extends StatefulWidget {
  final bool songOrVideoCheck;
  const SongSearchScreen({super.key, required this.songOrVideoCheck});

  @override
  State<SongSearchScreen> createState() => _SongSearchScreenState();
}

class _SongSearchScreenState extends State<SongSearchScreen> {
  @override
  void initState() {
    videoLoading();
    songLoading();
    setState(() {});
    super.initState();
  }

  late List<SongModel> allSongs;
  List<SongModel> foundSongs = [];
  OnAudioQuery onAudioQuery = OnAudioQuery();
  AudioPlayer audioPlayer = AudioPlayer();
  List foundVideos = [];
  late List allVideos;

  @override
  Widget build(BuildContext context) {
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
        title: TextField(
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
          onChanged: (value) => widget.songOrVideoCheck == true
              ? searchsong(value)
              : searchVideo(value),
        ),
      ),

      // ====================SafeArea====================
      body: SafeArea(
        child: foundSongs.isNotEmpty && foundVideos.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: foundSongs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: widget.songOrVideoCheck == true
                        ? () {
                            PageManger.audioPlayer.setAudioSource(
                                PageManger.songListCreating(
                                  foundSongs,
                                ),
                                initialIndex: index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PlayinMusicScreen(
                                    songModelList: foundSongs,
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
                                  isModelorPath: false,
                                  paths: foundVideos,
                                  index: index,
                                ),
                              ),
                            );
                          },

                    // ==================title===================
                    title: widget.songOrVideoCheck == true
                        ? Text(foundSongs[index].title,
                            overflow: TextOverflow.ellipsis)
                        : Text(foundVideos[index].toString().split('/').last,
                            overflow: TextOverflow.ellipsis),
                    // ==================Subtitle===================
                    subtitle: widget.songOrVideoCheck == true
                        ? Text(foundSongs[index].artist == null ||
                                foundSongs[index].artist == "<unknown>"
                            ? "Unknown Artist"
                            : foundSongs[index].artist!)
                        : const Text(''),

                    // =================Leading======================
                    leading: widget.songOrVideoCheck == true
                        ? QueryArtworkWidget(
                            artworkWidth: 58,
                            artworkHeight: 58,
                            id: foundSongs[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage: const AssetImage(
                                  "assets/images/pexels-foteros-352505.jpg"),
                              radius: 30,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.music_note_outlined,
                                      color: Colors.white.withAlpha(105),
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : thumbnail(path: foundVideos[index], choice: true),

                    // ==================Trailing=====================
                    trailing: widget.songOrVideoCheck == true
                        ?
                        // =====================SONGS TRAILNGS===================
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ============Favorite Icon(adding & deleting)=============
                              IconButton(
                                onPressed: () async {
                                  setState(
                                    () {
                                      if (FavouriteDb.isFavour(
                                          foundSongs[index])) {
                                        FavouriteDb.delete(
                                            foundSongs[index].id);
                                      } else {
                                        FavouriteDb.add(foundSongs[index]);
                                      }
                                    },
                                  );

                                  FavouriteDb.favouritesSongs.notifyListeners();
                                },
                                icon: FavouriteDb.isFavour(foundSongs[index])
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.black,
                                      ),
                              ),

                              // ===========Morevert ICon For Add Playlist==============
                              PopupMenuButton(
                                onSelected: (value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SongPlaylistScreen(
                                          // addtoPlaylist: item.data![index],
                                          findex: index,
                                          playlistSongsShowornot: false,
                                        );
                                      },
                                    ),
                                  );
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: const Text("Add PlayList"),
                                    onTap: () {},
                                  )
                                ],
                              )
                            ],
                          )
                        :
                        // =====================ViDEO TRAILINGS===================
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      if (VideoFavoriteDb.isVideoFavor(
                                        PlayersVideoFavoriteModel(
                                            path: foundVideos[index],
                                            title: foundVideos[index]
                                                .toString()
                                                .split('/')
                                                .last),
                                      )) {
                                        VideoFavoriteDb.delete(
                                            foundVideos[index]);
                                      } else {
                                        VideoFavoriteDb.add(
                                          PlayersVideoFavoriteModel(
                                              path: foundVideos[index],
                                              title: foundVideos[index]
                                                  .toString()
                                                  .split('/')
                                                  .last),
                                        );
                                      }
                                    },
                                  );

                                  VideoFavoriteDb.videoFavoriteDb
                                      .notifyListeners();
                                },
                                icon: VideoFavoriteDb.isVideoFavor(
                                  PlayersVideoFavoriteModel(
                                      path: foundVideos[index],
                                      title: foundVideos[index]
                                          .toString()
                                          .split('/')
                                          .last),
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
                child: Text(widget.songOrVideoCheck == true
                    ? 'Songs not found'
                    : "Videos not found"),
              ),
      ),
    );
  }

  songLoading() async {
    allSongs = PageManger.songscopy;
    // allSongs = await onAudioQuery.querySongs(
    //   sortType: null,
    //   orderType: OrderType.ASC_OR_SMALLER,
    //   uriType: UriType.EXTERNAL,
    //   ignoreCase: true,
    // );
    foundSongs = allSongs;
  }

  videoLoading() {
    allVideos = accessVideosPath;
    foundVideos.addAll(allVideos);
  }

  searchsong(String enterdKeyWords) {
    List<SongModel> result = [];
    if (enterdKeyWords.isEmpty) {
      result = allSongs;
    } else {
      result = allSongs
          .where((element) => element.title
              .toLowerCase()
              .contains(enterdKeyWords.toLowerCase()))
          .toList();
    }
    setState(
      () {
        foundSongs = result;
      },
    );
  }

  searchVideo(String enteredKeyWords) {
    List result = [];
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
}
