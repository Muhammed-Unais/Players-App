import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';

class SearchController extends ChangeNotifier {
  late List<SongModel> _allSongs;
  List<SongModel> _foundSongs = [];
  List<SongModel> result = [];

  List<SongModel> get foundSongs => _foundSongs;

  songLoading() async {
    _allSongs = PageManger.songscopy;
    _foundSongs = _allSongs;
  }

  searchsong(String enterdKeyWords) {
    if (enterdKeyWords.isEmpty) {
      result = _allSongs;
      notifyListeners();
    } else {
      result = _allSongs
          .where((element) => element.title
              .toLowerCase()
              .contains(enterdKeyWords.toLowerCase()))
          .toList();
      notifyListeners();
    }
    foundSongsAssaign();
  }

  foundSongsAssaign() {
    _foundSongs = result;
    notifyListeners();
  }
}
