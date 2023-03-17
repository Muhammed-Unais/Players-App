import 'package:flutter/material.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';

class MusicPlaying extends ChangeNotifier {
  int _large = 0;
  int get large => _large;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  Duration _duration = const Duration();
  Duration get duration => _duration;

  Duration _position = const Duration();
  Duration get position => _position;

  bool _isPlaying = true;
  bool get isPlaying => _isPlaying;

  playButton() {
    if (PageManger.audioPlayer.playing) {
      PageManger.audioPlayer.pause();
    } else {
      PageManger.audioPlayer.play();
    }
    _isPlaying = !_isPlaying;
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    PageManger.audioPlayer.seek(duration);
  }

  void changeSlider(double value) {
    changeToSeconds(value.toInt());
    value = value;
    notifyListeners();
  }

  //  ==============  //
  initState(songModelList, count) {
    PageManger.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          PageManger.currerentIndexes = index;
          _large = count - 1;
          _currentIndex = index;
          notifyListeners();
        }
      },
    );
    playSong();
    notifyListeners();
  }

  // Playing audio function
  void playSong() async {
    PageManger.audioPlayer.play();
    PageManger.audioPlayer.durationStream.listen((d) {
      if (d != null) {
        _duration = d;
        notifyListeners();
      }
    });
    PageManger.audioPlayer.positionStream.listen((p) {
      _position = p;
      notifyListeners();
    });
  }

  // ==========//
  // void updateCurrentPlayingSongDetails(
  //     {required int index,
  //     required List<SongModel> songModelList,
  //     required int currentIndex}) {
  //   if (songModelList.isNotEmpty) {
  //     _currentIndex = index;
  //   }
  //   notifyListeners();
  // }
}
