import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:players_app/functions/playlist_add_and_minimize.dart';
import 'package:players_app/functions/songmodelcontrollers/favouritedbfunctions.dart';
import 'package:players_app/model/db/dbmodel.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/screens/home.dart';
import 'package:players_app/screens/music/playlist/song_adding_playlist.dart';
import 'package:players_app/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'functions/songmodelcontrollers/playlistfunctions.dart';
import 'widgets/home widgets/home_navbar.dart';

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
      ChangeNotifierProvider(create: (context) => FavouriteMusicDb(),),
      ChangeNotifierProvider(create: (context) => PlaylistDbSong(),),
      ChangeNotifierProvider(create: (context) => Test(),),
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
