import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:players_app/model/db/videodb_model.dart';

class PlaylistVideoDb extends ChangeNotifier {
  static final videoPlaylisdb =
      Hive.box<PlayersVideoPlaylistModel>('VideoplaylistDB');
  static ValueNotifier<List<PlayersVideoPlaylistModel>> videoPlaylistNotifier =
      ValueNotifier([]);

  static add(PlayersVideoPlaylistModel value) async {
    await videoPlaylisdb.add(value);
    videoPlaylistNotifier.value.add(value);
    videoPlaylistNotifier.notifyListeners();
  }

  static getAllPlaylistVideos() {
    videoPlaylistNotifier.value.clear();
    videoPlaylistNotifier.value.addAll(videoPlaylisdb.values);
    videoPlaylistNotifier.notifyListeners();
  }

  static deleteVideoPlaylist(int index) async {
    await videoPlaylisdb.deleteAt(index);
    getAllPlaylistVideos();
    videoPlaylistNotifier.notifyListeners();
  }

  static updateVideoPlaylist(int index, PlayersVideoPlaylistModel value) async {
    await videoPlaylisdb.putAt(index, value);
    getAllPlaylistVideos();
  }

  static bool checkSameName(PlayersVideoPlaylistModel value) {
    final datas = videoPlaylisdb.values.map((e) => e.name);
    if (datas.contains(value.name)) {
      return true;
    } else {
      return false;
    }
  }
}
