import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:players_app/view/music/playlist/controller/playlist_add_and_minimize.dart';
import 'package:players_app/controllers/song_folder/favorite_songdb.dart';
import 'package:players_app/view/videos/play_screen/controller/video_controllers.dart';
import 'package:players_app/view/videos/playlist_videos/controller/playlist_add_delete.dart';
import 'package:players_app/controllers/video_folder/video_favorite_db.dart';
import 'package:players_app/controllers/video_folder/videodbplaylist.dart';
import 'package:players_app/model/db/dbmodel.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/genaral_screens.dart/home.dart';
import 'package:players_app/view/genaral_screens.dart/splashscreen.dart';
import 'package:players_app/view/music/playing_screen/controllers/music_playing_control.dart';
import 'package:players_app/view/music/song_search.dart/controller/search_controller.dart';
import 'package:provider/provider.dart';
import 'controllers/song_folder/playlist_db_song.dart';
import 'view/widgets/home widgets/home_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(PlayersmodelAdapter().typeId)) {
    Hive.registerAdapter(PlayersmodelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayersVideoFavoriteModelAdapter().typeId)) {
    Hive.registerAdapter(PlayersVideoFavoriteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayersVideoPlaylistModelAdapter().typeId)) {
    Hive.registerAdapter(PlayersVideoPlaylistModelAdapter());
  }

  await Hive.initFlutter();

  await Hive.openBox<PlayersVideoPlaylistModel>('VideoplaylistDB');
  await Hive.openBox<int>('FavoriteDB');
  await Hive.openBox<String>('VideoFavoriteDB');
  await Hive.openBox<Playersmodel>('SongPlaylistDB');

  runApp(
    MultiProvider(
     providers: [
      ChangeNotifierProvider(create: (context) => FavouriteSongDb(),),
      ChangeNotifierProvider(create: (context) => PlaylistDbSong(),),
      ChangeNotifierProvider(create: (context) => SongAddingpage(),),
      ChangeNotifierProvider(create: (context) => MusicPlaying(),),
      ChangeNotifierProvider(create: (context) => SearchController(),),
      ChangeNotifierProvider(create: (context) => VideoFavoriteDb(),),
      ChangeNotifierProvider(create: (context) => PlaylistVideoDb(),),
      ChangeNotifierProvider(create: (context) => VideoPlaylistAddDelete(),),
      ChangeNotifierProvider(create: (context) => VideoControllers(),)
     ],
      child: MaterialApp(
        initialRoute: "spalshScreen",
        routes: {
          "homeScreen": (context) => const HomeScreen(),
          "spalshScreen": (context) => const SplashScreen(),
          "bottomNavbar": (context) => const HomeBottomNavBar(),
        },
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
