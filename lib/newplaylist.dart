import 'package:akshathi/home.dart';
import 'package:akshathi/main.dart';
import 'package:akshathi/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'provider.dart';


class PlaylistTitleName extends StatelessWidget {
  var title;

  PlaylistTitleName({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.only(top: 30,right: 60),
        child: Column(
          children: [
            Text(
               this.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),
            ),
          ],
        ),
      ),
    );
  }
}


class Newplaylist extends StatefulWidget {

  String? playlistName;
  int? playlistKey;


   Newplaylist({this.playlistKey,this.playlistName});

  @override
  State<Newplaylist> createState() => _NewplaylistState();
}





class _NewplaylistState extends State<Newplaylist> {

  Box<QuerySongs>? querySongsDbInstance;
  Box<PlaylistSongs>? playlistSongsDbInstance;
  Box<NewPlaylistName>? newPlaylistNameDbInstance;

  bool isAdded= false;

  @override
  void initState() {
    newPlaylistNameDbInstance = Hive.box<NewPlaylistName>(newPlaylistBoxName);
    playlistSongsDbInstance = Hive.box<PlaylistSongs>(newPlaylistSongBoxName);
    querySongsDbInstance = Hive.box<QuerySongs>(songDetailListBoxName);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
        ),
        backgroundColor: Colors.black,
        title: PlaylistTitleName(title: widget.playlistName,),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children:   [
              const SizedBox(
                height: 10,
              ),
             const Icon(
               Icons.queue_music_outlined,size: 80.0,color: Colors.white,
             ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No songs added yet.',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 10,),
             const  Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('You can start with your recently played songs below.',style: TextStyle(color: Colors.white),),
              ),
             const SizedBox(height: 20,),
              addToPlaylistSongList(context),
            ],
          ),),
      )
      ,
    );
  }

  addToPlaylistSongList(BuildContext context) {
    return Consumer<PlayerItems>(
        builder: (_, setSongDetails, child) => ValueListenableBuilder(
          valueListenable: querySongsDbInstance!.listenable(),
          builder: (context, Box<QuerySongs> songFetcher, _) {
            List<int> keys = songFetcher.keys.cast<int>().toList();
            if (songFetcher.isEmpty) {
              return Column(
                children: const [
                  Text("No Songs So Far..."),
                ],
              );
            }else{
              return ListView.builder(
                itemCount: keys.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context,index){
                  final key = keys[index];
                  final songData = songFetcher.get(key);
                  return ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: QueryArtworkWidget(
                          id: songData!.imageId!,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipRRect(
                              child: Image.asset(
                                "assets/images/songsnew.png",
                                height: 50,
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          artworkHeight: 50,
                          artworkWidth: 50,
                          artworkFit: BoxFit.fill,
                          artworkBorder: BorderRadius.circular(10)),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                          songData.title.toString(),
                          style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.blue),),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                           songData.artist.toString(),
                          style: const TextStyle(
                          fontSize: 12,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                          ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: isAdded ? Colors.red : Colors.grey.shade500,
                      ),
                      onPressed: () {
                        final model = PlaylistSongs(currespondingPlaylistId: widget.playlistKey,songName: songData.title,artistName: songData.artist,songPath: songData.songPath,songDuration: songData.duration,songImageId: songData.imageId);
                        playlistSongsDbInstance!.add(model);
                        debugPrint("Add Button Clicked");
                      },
                    ),
                  );
                },);}
          },
        ));
  }


}
