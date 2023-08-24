
import 'package:hive_flutter/hive_flutter.dart';
part 'recently_played_videos_model.g.dart';

@HiveType(typeId: 5)
class RecentlyPlayedVideosModel {

  @HiveField(0)
  final String path;
  
  @HiveField(1)
  final int timeStamp;

  RecentlyPlayedVideosModel({required this.path, required this.timeStamp});
}
