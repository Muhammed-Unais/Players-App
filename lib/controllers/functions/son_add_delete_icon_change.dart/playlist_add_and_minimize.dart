import 'package:flutter/material.dart';
import 'package:players_app/model/db/dbmodel.dart';

class Test extends ChangeNotifier {
  
  add({required int id, required Playersmodel playersmodel}) {
    playersmodel.add(id);
    notifyListeners();
  }

  delete({required int id, required Playersmodel playersmodel}) {
    playersmodel.deleteData(id);
    notifyListeners();
  }
}