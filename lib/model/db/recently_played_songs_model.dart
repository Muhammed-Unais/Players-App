import 'package:hive_flutter/hive_flutter.dart';
part 'recently_played_songs_model.g.dart';

@HiveType(typeId: 4)
class RecentlyPlayedSongsModel extends HiveObject {

  @HiveField(0)
  final int? recentSongsId;

  @HiveField(1)
  final int timeStamp;


  RecentlyPlayedSongsModel({required this.recentSongsId,required this.timeStamp});
}
