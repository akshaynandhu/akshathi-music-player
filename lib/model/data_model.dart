import 'package:hive/hive.dart';
part 'data_model.g.dart';
@HiveType(typeId: 0)
class QuerySongs{
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? artist;

  @HiveField(2)
  final int? duration;

  @HiveField(3)
  final int? imageId;

  @HiveField(4)
  final String? songPath;

  @HiveField(5)
  final String? uri;

  @HiveField(6)
  final bool? isAddedtoPlaylist;

  @HiveField(7)
  final bool isFavourited;

  QuerySongs({
    required this.imageId,
    required this.songPath,
    required this.title,
    required this.artist,
    required this.duration,
    this.uri,
    this.isAddedtoPlaylist=false,
    this.isFavourited=false});

}

@HiveType(typeId: 1)
class NewPlaylistName{
  @HiveField(0)
  final String? playlistName;
  @HiveField(1)
  final int? correspondingKey;

  NewPlaylistName({this.playlistName, this.correspondingKey = 0});
}

@HiveType(typeId: 2)
class PlaylistSongs{

  @HiveField(0)
  final int? currespondingPlaylistId;
  @HiveField(1)
  final String? songName;
  @HiveField(2)
  final String? artistName;
  @HiveField(3)
  final String? songPath;
  @HiveField(4)
  final int? songDuration;
  @HiveField(5)
  final int? songImageId;

  PlaylistSongs({
    this.currespondingPlaylistId,
    this.songName,
    this.artistName,
    this.songPath,
    this.songDuration,
    this.songImageId});

}