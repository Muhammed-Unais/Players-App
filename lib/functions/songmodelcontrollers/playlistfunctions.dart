import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/db/dbmodel.dart';

class PlaylistDbSong extends ChangeNotifier {
  static ValueNotifier<List<Playersmodel>> texteditngcontroller =
      ValueNotifier([]);
  static final songPlayListDb = Hive.box<Playersmodel>("SongPlaylistDB");

  static add(Playersmodel value) async {
    await songPlayListDb.add(value);
    texteditngcontroller.value.add(value);
    texteditngcontroller.notifyListeners();
  }

  static getAllPlaylists() {
    texteditngcontroller.value.clear();
    texteditngcontroller.value.addAll(songPlayListDb.values);
    texteditngcontroller.notifyListeners();
  }

  static deletePlaylist(int index) async {
    await songPlayListDb.deleteAt(index);
    getAllPlaylists();
  }

  static editPlaylist(Playersmodel value, int index) async {
    await songPlayListDb.putAt(index, value);
    getAllPlaylists();
  }

  static bool checkSameName(Playersmodel value) {
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
