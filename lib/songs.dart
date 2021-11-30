import 'package:akshathi/main.dart';
import 'package:akshathi/model/data_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'assetaudio.dart';
import 'music.dart';

class Songs extends StatefulWidget {
  const Songs({Key? key}) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  Box<QuerySongs>? querySongsInstance;
  List<String> songsPaths =[];



  @override
  void initState() {
    querySongsInstance = Hive.box<QuerySongs>(songDetailListBoxName);
    getAllImagePaths();
    getSongPaths();
    super.initState();
  }

  getAllImagePaths(){
    var pInstance = Provider.of<PlayerItems>(context,listen:false);
    for (var element in querySongsInstance!.values) {
      pInstance.carousalImagepaths.add(element.imageId);
    }
   debugPrint("Carousal Paths Fetched");
  }


  getSongPaths(){
    final pInstance = Provider.of<PlayerItems>(context, listen: false);
    if(pInstance.allSongsplayList.isEmpty){
      for (var element in querySongsInstance!.values) {
        songsPaths.add(element.songPath!);
      }
    }
    pInstance.showKeys();
    debugPrint("Songlist Done");
  }
  changeModeOfPlay(){
    final pInstance = Provider.of<PlayerItems>(context, listen: false);
    pInstance.getAllSongsPaths(songsPaths);
    pInstance.modeOfPlaylist = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: image,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'SONGS',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: '\t\t\tsearch',
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            queriedSongs(),
          ],
        ),
      ),
    );
  }


  Widget queriedSongs(){
    return Expanded(
      child: Consumer<PlayerItems>(
          builder: (_, setSongDetails, child) =>ValueListenableBuilder(
        valueListenable: querySongsInstance!.listenable(),
        builder: (context,Box<QuerySongs>songFetcher,_){
          List<int> keys = songFetcher.keys.cast<int>().toList();
          return ListView.builder(
              itemCount: keys.length,
              itemBuilder: (context,index){
                var key = keys[index];
                var songData = songFetcher.get(key);
                return GestureDetector(
                  onTap: (){
                    // setSongDetails.isAllSongsAlreadyClicked = true;
                    changeModeOfPlay();
                    setSongDetails.selectedSongKey = key;
                    setSongDetails.currentSongDuration =
                        songData?.duration.toString();
                    setSongDetails.opnPlaylist(setSongDetails.selectedSongKey);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Nowplaying()));

                  },
                  child: ListTile(
                    title: Text(songData!.title!,style: TextStyle(color: Colors.white),),
                    subtitle: Text(songData.artist?? "No Artist",style: TextStyle(color: Colors.white),),
                    trailing: const Icon(Icons.play_arrow,color: Colors.white,),
                    leading: QueryArtworkWidget(
                      id: songData.imageId!,
                      type: ArtworkType.AUDIO,
                    ),
                  ),
                );
              });
        },
      )
      ),
    );
  }




  Widget get image {
    return const ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60),
          bottomLeft: Radius.circular(60),
        ),
        child: Image(
          image: AssetImage('assets/images/songs.jpg'),
        ));
  }



}
