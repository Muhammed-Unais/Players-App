import 'package:flutter/material.dart';
import 'package:players_app/model/db/dbmodel.dart';

class SongAddingpage extends ChangeNotifier {
  
  void add({required int id, required Playersmodel playersmodel}) {
    playersmodel.add(id);
    notifyListeners();
  }

  void delete({required int id, required Playersmodel playersmodel}) {
    playersmodel.deleteData(id);
    notifyListeners();
  }
}