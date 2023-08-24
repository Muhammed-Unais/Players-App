import 'package:hive_flutter/hive_flutter.dart';
part 'videodb_model.g.dart';

@HiveType(typeId: 1)
class PlayersVideoFavoriteModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String path;

  PlayersVideoFavoriteModel({required this.title, required this.path});
}

@HiveType(typeId: 2)
class PlayersVideoPlaylistModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> path;

  void add(String paths) async {
    path.add(paths);
    save();
  }

  void deleteData(String paths) {
    path.remove(paths);
    save();
  }

  bool isValueIn(String paths) {
    return path.contains(paths);
  }


  PlayersVideoPlaylistModel({required this.name, required this.path});
}
