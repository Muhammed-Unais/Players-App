import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:domedia/controllers/video_folder/access_folder/access_video.dart';
import 'package:domedia/model/db/videodb_model.dart';
import 'package:provider/provider.dart';

class VideoFavoriteDb extends ChangeNotifier {
  bool isIntialized = false;

  final videoDb = Hive.box<String>('VideoFavoriteDB');

  final List<PlayersVideoFavoriteModel> _videoFavoriteDb = [];

  List<PlayersVideoFavoriteModel> get videoFavoriteDb => _videoFavoriteDb;

  void intialize(PlayersVideoFavoriteModel video) {
    if (isVideoFavor(video)) {
      _videoFavoriteDb.add(video);
    }

    isIntialized = true;
  }

  bool isVideoFavor(PlayersVideoFavoriteModel video) {
    if (videoDb.values.contains(video.path)) {
      return true;
    }
    return false;
  }

  void add(PlayersVideoFavoriteModel value) {
    videoDb.add(value.path);
    var paths = _videoFavoriteDb.map((e) => e.path);
    if (!paths.contains(value.path)) {
      _videoFavoriteDb.add(value);
    }
    notifyListeners();
  }

  void delete(String path) async {
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
    _videoFavoriteDb.removeWhere((element) => element.path == path);
    notifyListeners();
  }

  void favoriteInitialize(BuildContext context) {
    var accessVideosPath =
        context.read<VideoFileAccessFromStorage>().accessVideosPath;
    if (!isIntialized) {
      for (int i = 0; i < accessVideosPath.length; i++) {
        intialize(
          PlayersVideoFavoriteModel(
            path: accessVideosPath[i],
            title: accessVideosPath[i].toString().split('/').last,
          ),
        );
      }
    }
  }

  void favouriteAddandDelete({required String path, required String title}) {
    if (isVideoFavor(
      PlayersVideoFavoriteModel(path: path, title: title),
    )) {
      delete(path);
      notifyListeners();
    } else {
      add(PlayersVideoFavoriteModel(title: title, path: path));
      notifyListeners();
    }
  }
}
