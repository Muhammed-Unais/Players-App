import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/db/dbmodel.dart';

class PlaylistDbSong extends ChangeNotifier {
  final List<Playersmodel> _texteditngcontroller = [];
  static final songPlayListDb = Hive.box<Playersmodel>("SongPlaylistDB");

  List<Playersmodel> get texteditngcontroller => _texteditngcontroller;

  Future<void> add(Playersmodel value) async {
    await songPlayListDb.add(value);
    _texteditngcontroller.add(value);
    notifyListeners();
  }

  Future<void> deletePlaylist(int index) async {
    await songPlayListDb.deleteAt(index);
    notifyListeners();
    getAllPlaylists();
  }

  Future<void> editPlaylist(Playersmodel value, int index) async {
    await songPlayListDb.putAt(index, value);
    notifyListeners();
    getAllPlaylists();
  }

  void getAllPlaylists() {
    _texteditngcontroller.clear();
    _texteditngcontroller.addAll(songPlayListDb.values);
  }

  bool checkSameName(Playersmodel value) {
    final dates = songPlayListDb.values.map(
      (e) => e.name.trim(),
    );

    if (dates.contains(value.name)) {
      return true;
    } else {
      return false;
    }
  }
}
