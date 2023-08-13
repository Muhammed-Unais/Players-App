// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_played_songs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyPlayedSongsModelAdapter
    extends TypeAdapter<RecentlyPlayedSongsModel> {
  @override
  final int typeId = 4;

  @override
  RecentlyPlayedSongsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyPlayedSongsModel(
      recentSongsId: fields[0] as int?,
      timeStamp: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyPlayedSongsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.recentSongsId)
      ..writeByte(1)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyPlayedSongsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
