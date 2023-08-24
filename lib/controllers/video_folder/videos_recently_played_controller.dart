import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:players_app/controllers/video_folder/access_folder/access_video.dart';
import 'package:players_app/model/db/recently_played_videos_model.dart';
import 'package:players_app/model/db/videodb_model.dart';

class VideosRecentlyPlayedController extends ChangeNotifier {
  var videoRecentBox =
      Hive.box<RecentlyPlayedVideosModel>('recently_played_videos');

  List<RecentlyPlayedVideosModel> _recentVidoesDbList = [];

  List<PlayersVideoFavoriteModel> recentVidoes = [];

  bool isInitiliaz = false;

  void initializeRecentVideos() {
    log("kerriii");
    getRecentVideos();
    var tempRecentvideos = List.filled(_recentVidoesDbList.length,
        PlayersVideoFavoriteModel(path: "", title: ""));

    for (var videoPath in accessVideosPath) {
      var recentVideoModel = PlayersVideoFavoriteModel(
          title: videoPath.split('/').last, path: videoPath.trim());

      for (var i = 0; i < _recentVidoesDbList.length; i++) {
        if (_recentVidoesDbList[i].path == videoPath) {
          tempRecentvideos[i] = recentVideoModel;
        }
      }
    }

    recentVidoes = [...tempRecentvideos];
    isInitiliaz = true;
  }

  Future<void> addToRecentVideos(
      {required String videoPath,
      required int timeStamp,
      int limit = 8}) async {
    var recentlyPlayedVideoModel =
        RecentlyPlayedVideosModel(path: videoPath, timeStamp: timeStamp);

    var videoPaths = videoRecentBox.values.map((e) => e.path);

    if (!videoPaths.contains(recentlyPlayedVideoModel.path)) {
      if (videoRecentBox.length >= limit) {
        var oldRecord = videoRecentBox.getAt(0);
        if (oldRecord != null) {
          await videoRecentBox.deleteAt(0);
        }
      }

      await videoRecentBox.add(recentlyPlayedVideoModel);
    } else {
      var listRecentVideos = videoRecentBox.toMap();

      listRecentVideos.forEach(
        (key, value) {
          if (recentlyPlayedVideoModel.path == value.path) {
            videoRecentBox.put(key, recentlyPlayedVideoModel);
          }
        },
      );
    }
    isInitiliaz = false;
    notifyListeners();
  }

  void getRecentVideos() {
    _recentVidoesDbList = videoRecentBox.values.toList();

    for (var i = 0; i < _recentVidoesDbList.length; i++) {
      bool isSorted = true;
      for (var j = 0; j < _recentVidoesDbList.length - i - 1; j++) {
        if (_recentVidoesDbList[j].timeStamp <
            _recentVidoesDbList[j + 1].timeStamp) {
          isSorted = false;
          var temp = _recentVidoesDbList[j];
          _recentVidoesDbList[j] = _recentVidoesDbList[j + 1];
          _recentVidoesDbList[j + 1] = temp;
        }
      }
      if (isSorted) {
        break;
      }
    }
  }
}
