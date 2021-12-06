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
    newPlaylistNameInstance = Hive.box<NewPlaylistName>(newPlaylistBoxName);
    playlistSongsInstance = Hive.box<PlaylistSongs>(newPlaylistSongBoxName);

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

  //favorite snackbar

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

  //playlist snackbar

  showPlaylistSnackBar({required BuildContext context, isAdded}) {
    final snack = SnackBar(
      content: isAdded!
          ? commonText(
          text: "Added to Playlist",
          color: Colors.green,
          size: 13,
          weight: FontWeight.w500,
          isCenter: true)
          : commonText(
          text: "Removed from Playlist",
          color: Colors.red,
          size: 13,
          weight: FontWeight.w500,
          isCenter: true),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.white,
      width: 250,
    );
    return ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  //Playlistnames

  showPlaylistNames(BuildContext context, songKey, songName) {
    bool alreadyExists = false;
    int? curr = 0;
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Select Playlist',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
        content: SizedBox(
          height: 100,
          width: 200,
          child: ValueListenableBuilder(
            valueListenable: newPlaylistNameInstance!.listenable(),
            builder: (context, Box<NewPlaylistName> songFetcher, _) {
              List songNonRepeatingPlaylistKey =
              newPlaylistNameInstance!.keys.cast<int>().toList();

              for (var element in playlistSongsInstance!.values) {
                if (element.songName == songName) {
                  alreadyExists = true;
                }
              }

              if (alreadyExists) {
                for (var element in playlistSongsInstance!.values) {
                  if (element.songName == songName) {
                    curr = element.currespondingPlaylistId;
                  }
                  for (var i = 0; i < songNonRepeatingPlaylistKey.length; i++) {
                    if (songNonRepeatingPlaylistKey[i] == curr) {
                      songNonRepeatingPlaylistKey.remove(curr);
                    }
                  }
                }
              } else if (alreadyExists == false) {
                songNonRepeatingPlaylistKey =
                    newPlaylistNameInstance!.keys.cast<int>().toList();
              }

              if (newPlaylistNameInstance!.isEmpty) {
                return SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text("!!! No Playlists Found !!!",style: TextStyle(color: Colors.white),),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            "Create & Add",
                            style: TextStyle(color: Colors.amber),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              createPlaylistAndAdd(context, songKey: songKey);
                            },
                            icon: Icon(Icons.add, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                if (songNonRepeatingPlaylistKey.isEmpty) {
                  return const Text(
                    "Already Added To Playlists",
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            final key = songNonRepeatingPlaylistKey[index];
                            final currentPlaylist = songFetcher.get(key);
                            return GestureDetector(
                              onTap: () {
                                final songData = querySongsInstance!.get(songKey);
                                final model = PlaylistSongs(
                                    currespondingPlaylistId: key,
                                    songName: songData!.title,
                                    artistName: songData.artist,
                                    songPath: songData.songPath,
                                    songImageId: songData.imageId,
                                    songDuration: songData.duration);
                                playlistSongsInstance!.add(model);
                                Navigator.of(context).pop();
                                showPlaylistSnackBar(
                                    context: context, isAdded: true);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        currentPlaylist!.playlistName
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => const Divider(color: Colors.red,),
                          itemCount: songNonRepeatingPlaylistKey.length,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            "New Playlist",
                            style: TextStyle(color: Colors.amber),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              createPlaylistAndAdd(context, songKey: songKey);
                            },
                            icon: const Icon(Icons.add, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  //to show playlistname in remove section

  showPlaylistNameToRemove(BuildContext context, songName) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Choose Playlist',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
        content: SizedBox(
          height: 100,
          width: 200,
          child: ValueListenableBuilder(
              valueListenable: newPlaylistNameInstance!.listenable(),
              builder: (context, Box<NewPlaylistName> songFetcher, _) {
                List<int> allCurrespondingKeys = [];
                List<int> verumKeys = playlistSongsInstance!.keys
                    .cast<int>()
                    .where((key) =>
                playlistSongsInstance!.get(key)!.songName ==
                    songName)
                    .toList();
                for (var element in playlistSongsInstance!.values) {
                  if (element.songName == songName) {
                    allCurrespondingKeys
                        .add(element.currespondingPlaylistId ?? 0);
                  }
                }

                int globalKey = 0;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            final key = allCurrespondingKeys[index];
                            final currentPlaylist = songFetcher.get(key);
                            globalKey = key;
                            return GestureDetector(
                              onTap: () {
                                List<int> keys = playlistSongsInstance!.keys
                                    .cast<int>()
                                    .where((key) =>
                                playlistSongsInstance!
                                    .get(key)!
                                    .currespondingPlaylistId ==
                                    key)
                                    .toList();
                                var songFetch = verumKeys[index];
                                // var songData = songFetch!.get(key);
                                showPlaylistSnackBar(
                                    context: context, isAdded: false);
                                playlistSongsInstance!.delete(songFetch);
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        currentPlaylist!.playlistName
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => const Divider(color: Colors.red,),
                          itemCount: allCurrespondingKeys.length),
                    ),
                    // Expanded(
                    //   child: ListTile(
                    //     title: const Text("New Playlist"),
                    //     trailing: IconButton(
                    //       onPressed: () {
                    //         Navigator.of(context).pop();
                    //         createPlaylistAndAdd(context, songKey: globalKey);
                    //       },
                    //       icon: const Icon(Icons.add),
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              }),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  //create and add to playlist

  createPlaylistAndAdd(BuildContext context, {songKey}) {
    var playlistName = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Create New Playlist',style: TextStyle(color: Colors.white),),
        content: TextFormField(
          controller: playlistName,
          decoration: const InputDecoration(hintText: "Your playlist name",hintStyle: TextStyle(color: Colors.grey),),
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel',style: TextStyle(color: Colors.blue),),
          ),
          TextButton(
            onPressed: () {
              createPlaylistSub(playlistName);
              final songData = querySongsInstance!.get(songKey);
              addToCreatedPlaylist(songData);
            },
            child: const Text('create',style: TextStyle(color: Colors.blue),),
          ),
        ],
      ),
    );
  }

  createPlaylistSub(playlistName) {
    final playlistNameFromTextField = playlistName.text;
    final playlistModelVariable =
    NewPlaylistName(playlistName: playlistNameFromTextField);
    newPlaylistNameInstance!.add(playlistModelVariable);
  }

  addToCreatedPlaylist(
      QuerySongs? songData,
      ) {
    final model = PlaylistSongs(
        currespondingPlaylistId: newPlaylistNameInstance!.keys.last,
        songName: songData!.title,
        artistName: songData.artist,
        songImageId: songData.imageId,
        songDuration: songData.duration,
        songPath: songData.songPath);
    playlistSongsInstance!.add(model);
    Navigator.of(context).pop();
    showPlaylistSnackBar(context: context, isAdded: true);
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
                style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
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
            shrinkWrap: true,
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
                    title: Text(songData!.title!,style: const TextStyle(color: Colors.red),),
                    subtitle: Text(songData.artist?? "No Artist",style: const TextStyle(color: Colors.white),),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
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
                          ),
                          Expanded(
                            child: PopupMenuButton(
                              icon: const Icon(Icons.expand_more_outlined,color: Colors.white,),
                              onSelected: (result) {
                                if (result == 1) {
                                  showPlaylistNames(
                                      context, key, songData.title);
                                } else {
                                  showPlaylistNameToRemove(
                                      context, songData.title);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  child: Text("Add to Playlist"),
                                  value: 1,
                                ),
                                const PopupMenuItem(
                                  child: Text("Remove from Playlist"),
                                  value: 2,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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
