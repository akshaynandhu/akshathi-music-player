import 'package:akshathi/main.dart';
import 'package:akshathi/model/data_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'provider.dart';
import 'music.dart';

class Songs extends StatefulWidget {
  const Songs({Key? key}) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  Box<QuerySongs>? querySongsInstance;
  Box<NewPlaylistName>? newPlaylistNameInstance;
  Box<PlaylistSongs>? playlistSongsInstance;

  List<String> songsPaths =[];



  @override
  void initState() {
    querySongsInstance = Hive.box<QuerySongs>(songDetailListBoxName);
    // newPlaylistNameInstance = Hive.box<NewPlaylistName>(newPlaylistBoxName);
    // playlistSongsInstance = Hive.box<PlaylistSongs>(newPlaylistBoxName);

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

  commonText(
      {text,
        color = Colors.black,
        double size = 18,
        family = "Poppins-Regular",
        weight = FontWeight.w700,
        isCenter = false}) {
    return Text(
      text.toString(),
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: style(weight: weight, size: size, family: family, color: color),
    );
  }

  style({color, size, family, weight}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontFamily: family,
      fontWeight: weight,
    );
  }

  changeModeOfPlay(){
    final pInstance = Provider.of<PlayerItems>(context, listen: false);
    pInstance.getAllSongsPaths(songsPaths);
    pInstance.modeOfPlaylist = 1;
  }

  showFavouriteSnackBar({required BuildContext context, isFavourite}) {
    final snack = SnackBar(
      content: isFavourite!
          ? commonText(
          text: "Added to Favourites",
          color: Colors.white,
          size: 13,
          weight: FontWeight.w500,
          isCenter: true)
          : commonText(
          text: "Removed from Favourites",
          color: Colors.black,
          size: 13,
          weight: FontWeight.w500,
          isCenter: true),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.red,
      width: 250,
    );
    return ScaffoldMessenger.of(context).showSnackBar(snack);
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
    bool addToFavs = false;
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
                    setSongDetails.isAudioPlayingFromPlaylist = false;
                    setSongDetails.isFavsAlreadyClicked = false;

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
                    trailing: IconButton(
                      onPressed: () {
                        if (songData.isFavourited == true) {
                          addToFavs = false;
                        } else {
                          addToFavs = true;
                        }
                        final model = QuerySongs(
                            title: songData.title,
                            artist: songData.artist,
                            duration: songData.duration,
                            songPath: songData.songPath,
                            imageId: songData.imageId,
                            isAddedtoPlaylist: false,
                            isFavourited: addToFavs);
                        songFetcher.putAt(key, model);
                        debugPrint("Added to Favourites $addToFavs");
                        showFavouriteSnackBar(
                            context: context, isFavourite: addToFavs);
                      },
                      icon: Icon(CupertinoIcons.heart,
                          color: songData.isFavourited
                              ? Colors.red
                              : Colors.white),
                    ),
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
