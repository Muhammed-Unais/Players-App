// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_played_videos_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyPlayedVideosModelAdapter
    extends TypeAdapter<RecentlyPlayedVideosModel> {
  @override
  final int typeId = 5;

  @override
  RecentlyPlayedVideosModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyPlayedVideosModel(
      path: fields[0] as String,
      timeStamp: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyPlayedVideosModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyPlayedVideosModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
