import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:domedia/controllers/song_and_video_playlistfolder/alert_dialotgue_songs_video_delete.dart';
import 'package:domedia/controllers/video_folder/video_favorite_db.dart';
import 'package:domedia/view/videos/play_screen/play_video_screen.dart';
import 'package:domedia/view/widgets/model_widget/listtale_songs_model.dart';
import 'package:domedia/view/widgets/thumbnail.dart';
import 'package:provider/provider.dart';

class VideoFavoriteScreen extends StatelessWidget {
  const VideoFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: Text(
          "Favorite Videos",
          style: GoogleFonts.raleway(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Consumer<VideoFavoriteDb>(
        builder: (context, videoFavorites, child) {
          if (!videoFavorites.isIntialized) {
            videoFavorites.favoriteInitialize(context);
          }
          final itemsOfVFavdb = videoFavorites.videoFavoriteDb;
          return videoFavorites.videoFavoriteDb.isEmpty
              ?  Center(
                  child: Text(
                    "No Favorites",
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                    itemCount: itemsOfVFavdb.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListtaleModelVidSong(
                          leading: thumbnail(
                              path: itemsOfVFavdb[index].path,
                              hight: 100,
                              width: 100),
                          title: itemsOfVFavdb[index].title,
                          trailingOne: IconButton(
                            onPressed: () {
                              deleteVideoAndSongs(context, "Delete", () {
                                videoFavorites.favouriteAddandDelete(
                                  path: itemsOfVFavdb[index].path,
                                  title: itemsOfVFavdb[index].title,
                                );
                                Navigator.pop(context);
                              });
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayVideoScreen(
                                  paths:
                                      itemsOfVFavdb.map((e) => e.path).toList(),
                                  index: index,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
