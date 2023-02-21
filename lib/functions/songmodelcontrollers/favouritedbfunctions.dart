import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteDb extends ChangeNotifier{
  static bool isIntialized = false;
  static final musicDb = Hive.box<int>('FavoriteDB');
  static ValueNotifier<List<SongModel>> favouritesSongs = ValueNotifier([]);

  static void isIntializ(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isFavour(song)) {
        favouritesSongs.value.add(song);
      }
    }
    isIntialized = true;
  }

  static isFavour(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  static add(SongModel song) async {
    musicDb.add(song.id);
    favouritesSongs.value.add(song);
    FavouriteDb.favouritesSongs.notifyListeners();
  }

  static delete(int id) async {
    int deletekey = 0;
    if (!musicDb.values.contains(id)) {
      return;
    }
    final Map<dynamic, dynamic> favourmap = musicDb.toMap();
    favourmap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    musicDb.delete(deletekey);
    favouritesSongs.value.removeWhere((song) => song.id == id);
  }
}
