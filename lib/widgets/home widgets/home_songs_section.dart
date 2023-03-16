import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/screens/music/playing_screen/playing_music_page.dart';

List<SongModel> songmodel = [];

class HomeSongSection extends StatefulWidget {
  // From home.dart

  const HomeSongSection({
    super.key,
  });

  @override
  State<HomeSongSection> createState() => HomeSongTileState();
}

class HomeSongTileState extends State<HomeSongSection> {
  // Define on audio plugin fetch from storage
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      // divice local storage audio
      future: _audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          sortType: null),
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
        if (item.data!.isEmpty) {
          return const Center(
            child: Text("No Songs Found"),
          );
        }
        PageManger.songscopy = item.data!;
        songmodel.addAll(item.data!);
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 120,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5),
          shrinkWrap: true,
          itemCount: (item.data!.length > 8 ? 8 : item.data!.length),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      PageManger.audioPlayer.setAudioSource(
                          PageManger.songListCreating(item.data!),
                          initialIndex: index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return PlayinMusicScreen(
                              songModelList: item.data!,
                              count: item.data!.length,
                            );
                          },
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 43,
                      backgroundColor: Colors.grey.shade500,
                      child: QueryArtworkWidget(
                        // artworkBorder: BorderRadius.circular(10),
                        artworkWidth: 79,
                        artworkHeight: 79,
                        keepOldArtwork: true,
                        artworkFit: BoxFit.cover,
                        id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: const AssetImage(
                              "assets/images/pexels-foteros-352505.jpg"),
                          radius: 40,
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
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  item.data![index].title,
                  style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
