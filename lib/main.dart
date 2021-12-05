import 'package:akshathi/home.dart';
import 'package:akshathi/model/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

const String songDetailListBoxName = 'querySongs';
const String newPlaylistBoxName = 'newPlaylistName';
const String newPlaylistSongBoxName = 'newPlaylistSongs';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(QuerySongsAdapter());
  Hive.registerAdapter(NewPlaylistNameAdapter());
  Hive.registerAdapter(PlaylistSongsAdapter());
  await Hive.openBox<QuerySongs>(songDetailListBoxName);
  await Hive.openBox<NewPlaylistName>(newPlaylistBoxName);
  await Hive.openBox<PlaylistSongs>(newPlaylistSongBoxName);

  runApp(MyApp());
}

// Widget queriedSongs(){
//   return Expanded(
//     child: FutureBuilder<List<SongModel>>(
//         future: audioQuery.querySongs(
//           sortType: null,
//           orderType: OrderType.ASC_OR_SMALLER,
//           uriType: UriType.EXTERNAL,
//           ignoreCase: true,
//         ),
//         builder: (context,item){
//           if(item.data == null) return const CircularProgressIndicator();
//
//           if(item.data!.isEmpty) return const  Text('No songs Found !');
//
//           return ListView.builder(
//               itemCount: item.data!.length,
//               itemBuilder: (context,index){
//                 return ListTile(
//                   title: Text(item.data![index].title,style: TextStyle(color: Colors.white),),
//                   subtitle: Text(item.data![index].artist?? "No Artist",style: TextStyle(color: Colors.white),),
//                   trailing: const Icon(Icons.play_arrow,color: Colors.white,),
//                   leading: QueryArtworkWidget(
//
//                     id: item.data![index].id,
//                     type: ArtworkType.AUDIO,
//                   ),
//                 );
//               });
//         }
//     ),
//   );
// }

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  List<SongModel> receivedSongs = [];
  Box<QuerySongs>? querySongs;

  receiveSongs() async {
    receivedSongs = await audioQuery.querySongs();

    if (querySongs!.isEmpty) {
      for (var element in receivedSongs) {
        final model = QuerySongs(
            imageId: element.id,
            songPath: element.data,
            title: element.title,
            artist: element.artist,
            duration: element.duration,
            uri: element.uri,);
        querySongs!.add(model);
      }
    } else {
      var list = querySongs!.values.toList();
      for (var i = 0; i < receivedSongs.length; i++) {
        debugPrint(receivedSongs[i].uri);
        for (var j = 0; j < querySongs!.length; j++) {
          if (receivedSongs[i].title != list[i].title) {
            final model = QuerySongs(
                imageId: receivedSongs[i].id,
                songPath: receivedSongs[i].data,
                title: receivedSongs[i].title,
                artist: receivedSongs[i].artist,
                duration: receivedSongs[i].duration,
                uri: receivedSongs[i].uri);

            querySongs!.add(model);
          } else {
            break;
          }
        }
      }
    }
  }

  @override
  void initState() {
    querySongs = Hive.box<QuerySongs>(songDetailListBoxName);
    requestPermission();
    receiveSongs();
    super.initState();
  }

  requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayerItems>(
      create: (_) => PlayerItems(),
      child: MaterialApp(
        title: 'Music App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
