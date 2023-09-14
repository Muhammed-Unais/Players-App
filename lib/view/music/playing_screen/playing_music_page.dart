import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:domedia/controllers/song_folder/page_manager.dart';
import 'package:domedia/controllers/song_folder/recently_played_controller.dart';
import 'package:domedia/view/music/playing_screen/controllers/music_playing_control.dart';
import 'package:domedia/view/music/playing_screen/widgets/play_next_previous_buttons.dart';
import 'package:domedia/view/music/playing_screen/widgets/shffle_repeat_fav_bottons.dart';
import 'package:domedia/view/music/playing_screen/widgets/slider_bar.dart';
import 'package:domedia/view/widgets/playing%20music%20page/playing_mu_circleavtar.dart';
import 'package:provider/provider.dart';

class PlayingMusicScreen extends StatefulWidget {
  const PlayingMusicScreen(
      {super.key,
      required this.songModelList,
      this.count = 0,
      required this.index});

  final List<SongModel> songModelList;
  final int count;
  final int index;

  @override
  State<PlayingMusicScreen> createState() => _PlayingMusicScreenState();
}

class _PlayingMusicScreenState extends State<PlayingMusicScreen> {
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
    context.read<RecentlyPlayedSongsController>().addToRecentSongs(
        songsId: widget.songModelList[widget.index].id,
        timeStamp: DateTime.now().toUtc().millisecondsSinceEpoch);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black,
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<MusicPlaying>(
          builder: (context, musicPlaying, _) {
            final songsModel = widget.songModelList[musicPlaying.currentIndex];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.03),
                  PlayinMusicCircleAvatar(songs: songsModel),
                  SizedBox(
                    height: size.height * 0.02,
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
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    songsModel.artist.toString() == "<unknown>"
                        ? "Unknown Artist"
                        : songsModel.artist.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SliderBar(
                    value: musicPlaying.position.inSeconds.toDouble(),
                    function: musicPlaying.changeSlider,
                    max: musicPlaying.duration.inSeconds.toDouble(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StreamBuilder<Duration?>(
                        stream: PageManger.audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            );
                          }
                          return Text(
                            snapshot.data.toString().trim().substring(2, 7),
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        musicPlaying.duration.toString().substring(2, 7),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  PlayNextPreviousButtons(
                      currentAudioSource: widget.songModelList),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ShuffleRepeatFavouriteButtons(
                    songModelList: widget.songModelList,
                    index: musicPlaying.currentIndex,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
