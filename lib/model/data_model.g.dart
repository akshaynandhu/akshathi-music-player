// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuerySongsAdapter extends TypeAdapter<QuerySongs> {
  @override
  final int typeId = 0;

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
      isAddedtoPlaylist: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, QuerySongs obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.uri)
      ..writeByte(6)
      ..write(obj.isAddedtoPlaylist);
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

class NewPlaylistNameAdapter extends TypeAdapter<NewPlaylistName> {
  @override
  final int typeId = 1;

  @override
  NewPlaylistName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewPlaylistName(
      playlistName: fields[0] as String?,
      correspondingKey: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, NewPlaylistName obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.correspondingKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewPlaylistNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlaylistSongsAdapter extends TypeAdapter<PlaylistSongs> {
  @override
  final int typeId = 2;

  @override
  PlaylistSongs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistSongs(
      currespondingPlaylistId: fields[0] as int?,
      songName: fields[1] as String?,
      artistName: fields[2] as String?,
      songPath: fields[3] as String?,
      songDuration: fields[4] as int?,
      songImageId: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistSongs obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.currespondingPlaylistId)
      ..writeByte(1)
      ..write(obj.songName)
      ..writeByte(2)
      ..write(obj.artistName)
      ..writeByte(3)
      ..write(obj.songPath)
      ..writeByte(4)
      ..write(obj.songDuration)
      ..writeByte(5)
      ..write(obj.songImageId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistSongsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
