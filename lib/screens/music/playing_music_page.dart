import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/functions/songmodelcontrollers/favouritedbfunctions.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/widgets/playing%20music%20page/play_music_buttons.dart';
import 'package:players_app/widgets/playing%20music%20page/playing_mu_circleavtar.dart';
import 'package:provider/provider.dart';

class PlayinMusicScreen extends StatefulWidget {
  const PlayinMusicScreen(
      {super.key, required this.songModelList, this.count = 0});
  final List<SongModel> songModelList;
  final int count;

  @override
  State<PlayinMusicScreen> createState() => _PlayinMusicScreenState();
}

final PageManger pageManager = PageManger();

class _PlayinMusicScreenState extends State<PlayinMusicScreen> {
  bool _isPlaying = true;
  bool isShuffle = false;
  int large = 0;
  int currentIndex = 0;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    PageManger.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          _updateCurrentPlayingSongDetails(index);
          if (mounted) {
            setState(
              () {
                large = widget.count - 1;
                currentIndex = index;
              },
            );
          }
          log('index of last song ${widget.count}');
        }
      },
    );
    super.initState();
    playSong();
  }

  // Playing audio function
  void playSong() async {
    PageManger.audioPlayer.play();
    PageManger.audioPlayer.durationStream.listen((d) {
      if (mounted && d != null) {
        setState(() {
          _duration = d;
        });
      }
    });
    PageManger.audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });
  }

  void _updateCurrentPlayingSongDetails(int index) {
    if (mounted) {
      setState(() {
        if (widget.songModelList.isNotEmpty) {
          currentIndex = index;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white),
        title: Text(
          "NOW PLAYING",
          style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600),
        ),
        centerTitle: true,
      ),

      // =============Body==================
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),

            // ==============Circle Avatar===============
            PlayinMusicCircleAvatar(songs: widget.songModelList[currentIndex]),
            const SizedBox(
              height: 20,
            ),

            Container(
              alignment: Alignment.center,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                widget.songModelList[currentIndex].displayNameWOExt,
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              widget.songModelList[currentIndex].artist.toString() ==
                      "<unknown>"
                  ? "Unknown Artist"
                  : widget.songModelList[currentIndex].artist.toString(),
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 50,
            ),

            // ================Slider Progress Bar Time================
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 7.0),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 2.0),
                  trackHeight: 3),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                child: Slider(
                  value: _position.inSeconds.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      changeToSeconds(value.toInt());
                      value = value;
                    });
                  },
                  min: 0.0,
                  max: _duration.inSeconds.toDouble(),
                  inactiveColor: Colors.grey,
                  activeColor: Colors.white,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  _position.toString().substring(2, 7),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  _duration.toString().substring(2, 7),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // =============Previous Button=================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PlaySongButtons(
                  hight: 40,
                  width: 40,
                  icons: IconButton(
                    onPressed: (() async {
                      if (mounted) {
                        if (PageManger.audioPlayer.hasPrevious) {
                          await PageManger.audioPlayer.seekToPrevious();
                          PageManger.audioPlayer.play();
                        } else {
                          PageManger.audioPlayer.play();
                        }
                      }
                    }),
                    icon: const Icon(Icons.skip_previous, color: Colors.black),
                  ),
                ),

                // =============Play&puase=================
                PlaySongButtons(
                  width: 60,
                  hight: 60,
                  icons: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            if (PageManger.audioPlayer.playing) {
                              PageManger.audioPlayer.pause();
                            } else {
                              PageManger.audioPlayer.play();
                            }
                            _isPlaying = !_isPlaying;
                          },
                        );
                      },
                      icon: Icon(
                        PageManger.audioPlayer.playing
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.black,
                      ),
                      tooltip: _isPlaying ? "Pause" : "Play"),
                ),
                // =============Next Song=================
                PlaySongButtons(
                    icons: IconButton(
                        onPressed: () async {
                          if (PageManger.audioPlayer.hasNext) {
                            await PageManger.audioPlayer.seekToNext();
                            PageManger.audioPlayer.play();
                          } else {
                            PageManger.audioPlayer.play();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.black,
                        ),
                        tooltip: "Skip Next"),
                    width: 40,
                    hight: 40),
              ],
            ),
            const SizedBox(
              height: 30,
            ),

            // =============Repeat&Shuffle,favorite=================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PlaySongButtons(
                    icons: IconButton(
                      onPressed: () {
                        isShuffle == false
                            ? PageManger.audioPlayer.setShuffleModeEnabled(true)
                            : PageManger.audioPlayer
                                .setShuffleModeEnabled(false);
                      },
                      icon: StreamBuilder<bool>(
                        stream: PageManger.audioPlayer.shuffleModeEnabledStream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            isShuffle = snapshot.data;
                          }
                          if (isShuffle) {
                            return const Icon(Icons.shuffle_on_outlined,
                                color: Colors.black);
                          } else {
                            return const Icon(
                              Icons.shuffle,
                              color: Colors.black,
                            );
                          }
                        },
                      ),
                    ),
                    width: 40,
                    hight: 40),

                //====================== repeat Button ===============
                PlaySongButtons(
                    icons: IconButton(
                      onPressed: () {
                        PageManger.audioPlayer.loopMode == LoopMode.one
                            ? PageManger.audioPlayer.setLoopMode(LoopMode.all)
                            : PageManger.audioPlayer.setLoopMode(LoopMode.one);
                      },
                      icon: StreamBuilder<LoopMode>(
                        stream: PageManger.audioPlayer.loopModeStream,
                        builder: (context, snapshot) {
                          final loopmode = snapshot.data;
                          if (LoopMode.one == loopmode) {
                            return const Icon(Icons.repeat_on,
                                color: Colors.black);
                          } else {
                            return const Icon(
                              Icons.repeat,
                              color: Colors.black,
                            );
                          }
                        },
                      ),
                    ),
                    width: 40,
                    hight: 40),

                // ===================Favorite Button======================
                PlaySongButtons(
                  // currently working ============================================================================================
                    icons: Consumer<FavouriteMusicDb>(
                        builder: (context, favouriteMusic, _) {
                      return IconButton(
                        onPressed: () {
                          if (favouriteMusic
                              .isFavour(widget.songModelList[currentIndex])) {
                            favouriteMusic
                                .delete(widget.songModelList[currentIndex].id);
                          } else {
                            favouriteMusic
                                .add(widget.songModelList[currentIndex]);
                          }
                        },
                        icon: favouriteMusic
                                .isFavour(widget.songModelList[currentIndex])
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                              ),
                      );
                    }),
                    width: 40,
                    hight: 40),
              ],
            )
          ],
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    PageManger.audioPlayer.seek(duration);
  }
}
