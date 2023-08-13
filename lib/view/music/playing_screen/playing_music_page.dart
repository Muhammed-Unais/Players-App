import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/recently_played_controller.dart';
import 'package:players_app/view/music/playing_screen/controllers/music_playing_control.dart';
import 'package:players_app/view/music/playing_screen/widgets/favorite_button.dart';
import 'package:players_app/view/music/playing_screen/widgets/next_button.dart';
import 'package:players_app/view/music/playing_screen/widgets/playbutton.dart';
import 'package:players_app/view/music/playing_screen/widgets/previous_button.dart';
import 'package:players_app/view/music/playing_screen/widgets/repeat_button.dart';
import 'package:players_app/view/music/playing_screen/widgets/shuffle_button.dart';
import 'package:players_app/view/music/playing_screen/widgets/slider_bar.dart';
import 'package:players_app/view/widgets/playing%20music%20page/playing_mu_circleavtar.dart';
import 'package:provider/provider.dart';

class PlayinMusicScreen extends StatefulWidget {
  const PlayinMusicScreen(
      {super.key,
      required this.songModelList,
      this.count = 0,
      required this.index});

  final List<SongModel> songModelList;
  final int count;
  final int index;

  @override
  State<PlayinMusicScreen> createState() => _PlayinMusicScreenState();
}

class _PlayinMusicScreenState extends State<PlayinMusicScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MusicPlaying>(context, listen: false)
          .initState(widget.songModelList, widget.count);
      addToRecentSongs();
    });

    super.initState();
  }

  void addToRecentSongs() {
    log("addToRecentSongsCalled");
    context.read<RecentlyPlayedSongsController>().addToRecentSongs(
        songsId: widget.songModelList[widget.index].id,
        timeStamp: DateTime.now().toUtc().millisecondsSinceEpoch);
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
            color: Colors.grey.shade600,
          ),
        ),
        centerTitle: true,
      ),
      // =============Body==================
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<MusicPlaying>(builder: (context, musicPlaying, _) {
          final songsModel = widget.songModelList[musicPlaying.currentIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              // ==============Circle Avatar===============
              PlayinMusicCircleAvatar(songs: songsModel),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  songsModel.displayNameWOExt,
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
                songsModel.artist.toString() == "<unknown>"
                    ? "Unknown Artist"
                    : songsModel.artist.toString(),
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // ================Slider Progress Bar Time================
              SliderBar(
                value: musicPlaying.position.inSeconds.toDouble(),
                function: (value) => musicPlaying.changeSlider(value),
                max: musicPlaying.duration.inSeconds.toDouble(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    musicPlaying.position.toString().substring(2, 7),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    musicPlaying.duration.toString().substring(2, 7),
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
                  const PreviousButton(),
                  // =============Play&puase=================
                  PlayPausebutton(
                    isPlaying: musicPlaying.isPlaying,
                    function: () => musicPlaying.playButton(),
                  ),
                  // =============Next Song=================
                  const NextButton(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const ShuffleButton(),
                  //====================== repeat Button ===============
                  const RepeatButton(),
                  // ===================Favorite Button======================
                  FavoriteButton(
                    songModelList: widget.songModelList,
                    currentIndex: musicPlaying.currentIndex,
                  )
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
