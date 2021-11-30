import 'package:hive/hive.dart';
part 'data_model.g.dart';
@HiveType(typeId: 1)
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
  QuerySongs({required this.imageId, required this.songPath, required this.title, required this.artist, required this.duration,this.uri});

}