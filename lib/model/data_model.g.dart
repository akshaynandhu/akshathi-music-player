// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuerySongsAdapter extends TypeAdapter<QuerySongs> {
  @override
  final int typeId = 1;

  @override
  QuerySongs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuerySongs(
      imageId: fields[3] as int?,
      songPath: fields[4] as String?,
      title: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[2] as int?,
      uri: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuerySongs obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.imageId)
      ..writeByte(4)
      ..write(obj.songPath)
      ..writeByte(5)
      ..write(obj.uri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuerySongsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
