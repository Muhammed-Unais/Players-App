import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteSongDb extends ChangeNotifier {
  bool isIntialized = false;
  final musicDb = Hive.box<int>('FavoriteDB');
  final List<SongModel> _favouritesSongs = [];

  List<SongModel> get favouritesSongs => _favouritesSongs;

  void isIntializ(List<SongModel> songs) {
     _favouritesSongs.clear();
    for (SongModel song in songs) {
      if (isFavour(song)) {
        _favouritesSongs.add(song);
      }
    }
    isIntialized = true;
  }

  bool isFavour(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  add(SongModel song) async {
    musicDb.add(song.id);
    _favouritesSongs.add(song);
    notifyListeners();
  }

  delete(int id) async {
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
    await musicDb.delete(deletekey);
    _favouritesSongs.removeWhere((song) => song.id == id);
    notifyListeners();
  }
}
