import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';
import 'package:players_app/model/db/recently_played_songs_model.dart';

class RecentlyPlayedSongsController extends ChangeNotifier {
  var box = Hive.box<RecentlyPlayedSongsModel>("recently_played");

  List<RecentlyPlayedSongsModel> _listRecentSongs = [];

  List<SongModel> recentSongs = [];

  bool isIntialize = false;


  Future<List<SongModel>> initializRecentSongs() async {
    final OnAudioQuery audioQuery = OnAudioQuery();
    getSortedRecentSongs();

    var listofSongs = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        sortType: null);

    PageManger.songscopy = listofSongs;
    recentSongs.clear();

    List<SongModel> tempRecentSongs =
        List.filled(_listRecentSongs.length, SongModel({}));

    for (var songmodel in listofSongs) {
      if (isRecentlySong(songmodel.id)) {
        for (var i = 0; i < _listRecentSongs.length; i++) {
          if (_listRecentSongs[i].recentSongsId == songmodel.id) {
            tempRecentSongs[i] = songmodel;
          }
        }
      }
    }

    recentSongs = [...tempRecentSongs];
    isIntialize = true;

    notifyListeners();

    return recentSongs;
  }

  bool isRecentlySong(int songId) {
    var songsIds = _listRecentSongs.map((e) => e.recentSongsId);

    if (songsIds.contains(songId)) return true;

    return false;
  }

  Future<void> addToRecentSongs(
      {required int? songsId, required int timeStamp, int limit = 8}) async {
    var recentSongsModel =
        RecentlyPlayedSongsModel(recentSongsId: songsId, timeStamp: timeStamp);

    var songsIds = box.values.map((e) => e.recentSongsId);

    if (!songsIds.contains(recentSongsModel.recentSongsId)) {
      if (box.length >= limit) {
        var oldRecord = box.getAt(0);
        if (oldRecord != null) {
          await box.deleteAt(0);
        }
      }

      await box.add(recentSongsModel);
    } else {
      var listofSongs = box.toMap();
      listofSongs.forEach(
        (key, value) {
          if (recentSongsModel.recentSongsId == value.recentSongsId) {
            box.put(key, recentSongsModel);
          }
        },
      );
    }

    isIntialize = false;
  }

  void getSortedRecentSongs() {
    _listRecentSongs = box.values.toList();
    for (var i = 0; i < _listRecentSongs.length; i++) {
      bool flag = false;
      for (var j = 0; j < _listRecentSongs.length - i - 1; j++) {
        if (_listRecentSongs[j].timeStamp < _listRecentSongs[j + 1].timeStamp) {
          flag = true;
          final temp = _listRecentSongs[j];
          _listRecentSongs[j] = _listRecentSongs[j + 1];
          _listRecentSongs[j + 1] = temp;
        }
      }
      if (!flag) {
        break;
      }
    }
  }
}
