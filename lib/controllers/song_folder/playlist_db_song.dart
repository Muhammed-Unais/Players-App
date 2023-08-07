import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/db/dbmodel.dart';

class PlaylistDbSong extends ChangeNotifier {
  final List<Playersmodel> _texteditngcontroller = [];
  static final songPlayListDb = Hive.box<Playersmodel>("SongPlaylistDB");

  List<Playersmodel> get texteditngcontroller => _texteditngcontroller;

  add(Playersmodel value) async {
    await songPlayListDb.add(value);
    _texteditngcontroller.add(value);
    notifyListeners();
  }

  deletePlaylist(int index) async {
    await songPlayListDb.deleteAt(index);
    notifyListeners();
    getAllPlaylists();
  }

  editPlaylist(Playersmodel value, int index) async {
    await songPlayListDb.putAt(index, value);
    notifyListeners();
    getAllPlaylists();
  }

  getAllPlaylists() {
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
