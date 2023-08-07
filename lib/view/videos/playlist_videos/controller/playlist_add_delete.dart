import 'package:flutter/material.dart';
import 'package:players_app/model/db/videodb_model.dart';

class VideoPlaylistAddDelete extends ChangeNotifier {
  add(
      {required PlayersVideoPlaylistModel playersVideoPlaylistModel,
      required String path}) {
    playersVideoPlaylistModel.add(path);
    notifyListeners();
  }

  delete(
      {required PlayersVideoPlaylistModel playersVideoPlaylistModel,
      required String path}) {
    playersVideoPlaylistModel.deleteData(path);
    notifyListeners();
  }
}
