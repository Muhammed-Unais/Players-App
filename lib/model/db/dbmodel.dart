import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'dbmodel.g.dart';

@HiveType(typeId: 1)
class Playersmodel extends HiveObject with ChangeNotifier {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<int> songid;


  add(int id) async {
    songid.add(id);
    save();
  }

  deleteData(int id) {
    songid.remove(id);
    save();
  }

  bool isValueIn(int id) {
    notifyListeners();
    return songid.contains(id);
  }

  Playersmodel({required this.name, required this.songid,});
}
