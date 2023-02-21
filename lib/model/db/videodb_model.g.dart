// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videodb_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayersVideoFavoriteModelAdapter
    extends TypeAdapter<PlayersVideoFavoriteModel> {
  @override
  final int typeId = 1;

  @override
  PlayersVideoFavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayersVideoFavoriteModel(
      title: fields[0] as String,
      path: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlayersVideoFavoriteModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayersVideoFavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayersVideoPlaylistModelAdapter
    extends TypeAdapter<PlayersVideoPlaylistModel> {
  @override
  final int typeId = 2;

  @override
  PlayersVideoPlaylistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayersVideoPlaylistModel(
      name: fields[0] as String,
      path: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayersVideoPlaylistModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayersVideoPlaylistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
