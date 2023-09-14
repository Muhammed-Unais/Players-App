import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:domedia/model/db/videodb_model.dart';

class PlaylistVideoDb extends ChangeNotifier {
  final videoPlaylisdb = Hive.box<PlayersVideoPlaylistModel>('VideoplaylistDB');

  final List<PlayersVideoPlaylistModel> _videoPlaylistNotifier = [];

  List<PlayersVideoPlaylistModel> get videoPlaylistNotifier =>
      _videoPlaylistNotifier;

  void add(PlayersVideoPlaylistModel value) async {
    await videoPlaylisdb.add(value);
    _videoPlaylistNotifier.add(value);
    notifyListeners();
  }
  void getAllPlaylistVideos() {
    _videoPlaylistNotifier.clear();
    _videoPlaylistNotifier.addAll(videoPlaylisdb.values);
  }

  void deleteVideoPlaylist(int index) async {
    await videoPlaylisdb.deleteAt(index);
    notifyListeners();
    getAllPlaylistVideos();
  }

  void updateVideoPlaylist(int index, PlayersVideoPlaylistModel value) async {
    await videoPlaylisdb.putAt(index, value);
    notifyListeners();
    getAllPlaylistVideos();
  }

  bool checkSameName(PlayersVideoPlaylistModel value) {
    final datas = videoPlaylisdb.values.map((e) => e.name.trim());
    if (datas.contains(value.name)) {
      return true;
    } else {
      return false;
    }
  }
}
