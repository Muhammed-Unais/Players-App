import 'package:flutter/material.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';

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

  void previousButton() async {
    _isPlaying = true;
    if (PageManger.audioPlayer.hasPrevious) {
      await PageManger.audioPlayer.seekToPrevious();
      PageManger.audioPlayer.play();
    } else {
      PageManger.audioPlayer.play();
    }
    notifyListeners();
  }

  void nextButton() async {
    _isPlaying = true;

    if (PageManger.audioPlayer.hasNext) {
      await PageManger.audioPlayer.seekToNext();
      PageManger.audioPlayer.play();
    } else {
      PageManger.audioPlayer.play();
    }
    notifyListeners();
  }

  void playButton() {
    if (PageManger.audioPlayer.playing) {
      PageManger.audioPlayer.pause();
    } else {
      PageManger.audioPlayer.play();
    }
    _isPlaying = PageManger.audioPlayer.playing;
    notifyListeners();
  }

  void changeSlider(double value) {
    Duration duration = Duration(seconds: value.toInt());
    PageManger.audioPlayer.seek(duration);
  }

  void initState(songModelList, count) {
    _isPlaying = true;
    PageManger.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          PageManger.currerentIndexes = index;
          _large = count - 1;
          _currentIndex = index;
        }
      },
    );
    playSong();
    notifyListeners();
  }

  void playSong() async {
    PageManger.audioPlayer.play();
    PageManger.audioPlayer.durationStream.listen((d) {
      if (d != null) {
        _duration = d;
      }
    });
    PageManger.audioPlayer.positionStream.listen((p) {
      _position = p;
    });
    notifyListeners();
  }

  @override
  void dispose() {
    PageManger.dispose();
    super.dispose();
  }
}
