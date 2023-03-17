import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:players_app/model/db/videodb_model.dart';

class VideoFavoriteDb extends ChangeNotifier{
  static bool isIntialized = false;
  static final videoDb = Hive.box<String>('VideoFavoriteDB');
  static ValueNotifier<List<PlayersVideoFavoriteModel>> videoFavoriteDb =
      ValueNotifier([]);

  static void intialize(PlayersVideoFavoriteModel value) {
    if (isVideoFavor(value)) {
      videoFavoriteDb.value.add(value);
      videoFavoriteDb.notifyListeners();
    }
    isIntialized = true;
  }

  static isVideoFavor(PlayersVideoFavoriteModel video) {
    if (videoDb.values.contains(video.path)) {
      return true;
    }
    return false;
  }

  static add(PlayersVideoFavoriteModel value) {
    videoDb.add(value.path);
    videoFavoriteDb.value.add(value);
    videoFavoriteDb.notifyListeners();
  }

  static delete(String path) async {
    int deletekey = 0;
    if (!videoDb.values.contains(path)) {
      return;
    }

    final Map<dynamic, String> favorMap = videoDb.toMap();
    favorMap.forEach((key, value) {
      if (value == path) {
        deletekey = key;
      }
    });
    videoDb.delete(deletekey);
    videoFavoriteDb.value.removeWhere((element) => element.path == path);
  }
}
