import 'package:domedia/controllers/song_folder/page_manager.dart';
import 'package:domedia/controllers/video_folder/access_folder/access_video.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:provider/provider.dart';

class SearchController extends ChangeNotifier {
  List<SongModel> _foundSongs = [];

  List<String> foundVideos = [];

  List<SongModel> get foundSongs => _foundSongs;

  void searchsong(String enterdKeyWords) {
    if (enterdKeyWords.isEmpty) {
      _foundSongs = [];
      notifyListeners();
    } else {
      _foundSongs = [
        ...PageManger.songscopy
            .where((element) => element.title
                .toLowerCase()
                .contains(enterdKeyWords.toLowerCase()))
            .toList()
      ];
      notifyListeners();
    }
  }

  void searchVideo(String enteredKeyWords, BuildContext context) {
    var allVideo = context.read<VideoFileAccessFromStorage>().accessVideosPath;
    if (enteredKeyWords.isEmpty) {
      foundVideos = [];
      notifyListeners();
    } else {
      foundVideos = [
        ...allVideo
            .where((element) => element
                .toString()
                .split('/')
                .last
                .toLowerCase()
                .contains(enteredKeyWords.toLowerCase()))
            .toList()
      ];
      notifyListeners();
    }
  }
}
