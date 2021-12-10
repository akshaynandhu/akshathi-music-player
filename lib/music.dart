import 'package:akshathi/provider.dart';
import 'package:akshathi/model/data_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttericon/typicons_icons.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'main.dart';

final controller = CarouselController();

class Nowplaying extends StatefulWidget {
  @override
  _NowplayingState createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> {

  Box<QuerySongs>? songDetailsBox;
  Box<NewPlaylistName>? userPlaylistNameInstance;
  Box<PlaylistSongs>? userPlaylistSongsInstance;
  List<String> songsPaths = [];
  List<int?> carousalImage = [
    // "assets/images/song1.jpg",
    // "assets/images/ola.jpg"
    //     "assets/images/kanmani.jpg",
    // "assets/images/now.jpg"
  ];

  // final urlImages =

  // bool isPlaying=false;
  // bool isPaused=false;

  bool click = true;

  // final List<IconData> _icons =[
  //   Icons.play_circle_fill,
  //   Icons.pause_circle_filled,
  // ];
  //
  // Widget btnStart(){
  //   return IconButton(
  //     iconSize: 70,
  //       padding: const EdgeInsets.only(bottom: 10),
  //       onPressed: (){
  //         if(isPlaying==false) {
  //           audioPlayer.play();
  //           setState(() {
  //             isPlaying = true;
  //           });
  //         }else if(isPlaying==true){
  //           audioPlayer.pause();
  //           setState(() {
  //             isPlaying=false;
  //           });
  //         }
  //   },
  //         icon: isPlaying==false?Icon(_icons[0]):Icon(_icons[1]));
  // }
  //
  // Duration? currentPos = Duration(seconds: 0);
  // Duration? total = Duration(seconds: 0);
  // double current =0;
  //
  // totalDuration(){
  //   audioPlayer.current.listen((event) {total=event!.audio.duration;});
  //   return Text(total.toString().split('.')[0]);
  // }
  //
  // getDuration(){
  //   return StreamBuilder(
  //       stream: audioPlayer.currentPosition,
  //       builder: (context, asyncSnapshot) {
  //         currentPos = asyncSnapshot.data as Duration;
  //         return Text(currentPos.toString().split('.')[0]);
  //       });
  // }
  //
  // currentSong(){
  //   current=currentPos!.inSeconds.toDouble();
  // }
  //
  // Widget slider(){
  //   return Slider(
  //     activeColor: Colors.black,
  //     inactiveColor: Colors.yellow,
  //     value: currentPos!.inSeconds.toDouble(),
  //     min: 0.0,
  //     max: total!.inSeconds.toDouble(),
  //     onChanged: (double newValue){
  //
  //       setState(() {
  //         seekToSec(current.toInt());
  //         current = newValue;
  //       });
  //     },
  //   );
  // }
  //
  //
  //
  // void setupPlaylist() async {
  //   audioPlayer.open(
  //       Playlist(audios: [
  //         Audio(
  //             'assets/songs/Darshana_320(PaglaSongs).mp3',
  //             metas: Metas(title: 'Darshana', artist: 'Hesham Abdul Wahab')),
  //         Audio(
  //             'assets/songs/AEVideoToAudio1622113883141.mp3',
  //             metas: Metas(title: 'Ola Ola', artist: 'Kate Linn')),
  //         Audio(
  //             "assets/songs/kanmani.mp3",
  //             metas: Metas(title: 'Kanmani Anbodu', artist: 'Sachin Siby')),
  //       ]),
  //       showNotification: true,
  //       autoStart: false);
  // }

  @override
  void initState() {
    songDetailsBox = Hive.box<QuerySongs>(songDetailListBoxName);
    userPlaylistNameInstance = Hive.box<NewPlaylistName>(newPlaylistBoxName);
    userPlaylistSongsInstance = Hive.box<PlaylistSongs>(newPlaylistSongBoxName);
    getAllImagePaths();
    super.initState();
  }

  getAllImagePaths() {
    var pInstance = Provider.of<PlayerItems>(context, listen: false);
    for (var element in pInstance.carousalImagepaths) {
      carousalImage.add(element);
    }
    debugPrint("Carousal Paths Fetched");
  }

  carousalBuilder() {
    var pInstance = Provider.of<PlayerItems>(context, listen: false);
    return CarouselSlider.builder(
      carouselController: controller,
      options: CarouselOptions(height: 400, enlargeCenterPage: true),
      itemCount: carousalImage.length,
      itemBuilder: (context, index, realIndex) {
        final urlImage = carousalImage[pInstance.selectedSongKey ?? 0];
        debugPrint("URI IMAGE IS $urlImage");
        // return buildImage(urlImage!, index);
        return QueryArtworkWidget(
          id: urlImage!,
          type: ArtworkType.ARTIST,
          nullArtworkWidget: Image.asset("assets/images/playingif.gif"),
        );
      },
    );
  }

  changeModeOfPlay(){
    final pInstance = Provider.of<PlayerItems>(context, listen: false);
    pInstance.getAllSongsPaths(songsPaths);
    pInstance.modeOfPlaylist = 1;
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

  // favorite snackbar

  showFavouriteSnackBar({required BuildContext context, isFavourite}) {
    final snack = SnackBar(
      content: isFavourite!
          ? commonText(
          text: "Added to Favourites",
          color: Colors.green,
          size: 13,
          weight: FontWeight.w500,
          isCenter: true)
          : commonText(
          text: "Removed from Favourites",
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

  // playlist snackbar

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
            valueListenable: userPlaylistNameInstance!.listenable(),
            builder: (context, Box<NewPlaylistName> songFetcher, _) {
              List songNonRepeatingPlaylistKey =
              userPlaylistNameInstance!.keys.cast<int>().toList();

              for (var element in userPlaylistSongsInstance!.values) {
                if (element.songName == songName) {
                  alreadyExists = true;
                }
              }

              if (alreadyExists) {
                for (var element in userPlaylistSongsInstance!.values) {
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
                    userPlaylistNameInstance!.keys.cast<int>().toList();
              }

              if (userPlaylistNameInstance!.isEmpty) {
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
                                final songData = songDetailsBox!.get(songKey);
                                print(songKey);
                                print(songData);
                                final model = PlaylistSongs(
                                    currespondingPlaylistId: key,
                                    songName: songData!.title,
                                    artistName: songData.artist,
                                    songPath: songData.songPath,
                                    songImageId: songData.imageId,
                                    songDuration: songData.duration);
                                userPlaylistSongsInstance!.add(model);
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
              valueListenable: userPlaylistNameInstance!.listenable(),
              builder: (context, Box<NewPlaylistName> songFetcher, _) {
                List<int> allCurrespondingKeys = [];
                List<int> verumKeys = userPlaylistSongsInstance!.keys
                    .cast<int>()
                    .where((key) =>
                userPlaylistSongsInstance!.get(key)!.songName ==
                    songName)
                    .toList();
                for (var element in userPlaylistSongsInstance!.values) {
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
                                List<int> keys = userPlaylistSongsInstance!.keys
                                    .cast<int>()
                                    .where((key) =>
                                userPlaylistSongsInstance!
                                    .get(key)!
                                    .currespondingPlaylistId ==
                                    key)
                                    .toList();
                                var songFetch = verumKeys[index];
                                // var songData = songFetch!.get(key);
                                showPlaylistSnackBar(
                                    context: context, isAdded: false);
                                userPlaylistSongsInstance!.delete(songFetch);
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
              final songData = songDetailsBox!.get(songKey);
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
    userPlaylistNameInstance!.add(playlistModelVariable);
  }

  addToCreatedPlaylist(
      QuerySongs? songData,
      ) {
    final model = PlaylistSongs(
        currespondingPlaylistId: userPlaylistNameInstance!.keys.last,
        songName: songData!.title,
        artistName: songData.artist,
        songImageId: songData.imageId,
        songDuration: songData.duration,
        songPath: songData.songPath);
    userPlaylistSongsInstance!.add(model);
    Navigator.of(context).pop();
    showPlaylistSnackBar(context: context, isAdded: true);
  }


  @override
  Widget build(BuildContext context) {
    bool addToFavs = false;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Now Playing',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Consumer<PlayerItems>(
        builder: (context, setSongDetails, child) => SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: songDetailsBox!.listenable(),
            builder: (context, Box<QuerySongs> songFetcher, child) {
              final songData = songFetcher.get(setSongDetails.selectedSongKey);
              return Padding(

                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    carousalBuilder(),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                IconButton(
                                  onPressed: () {
                                    if (songData!.isFavourited == true) {
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
                                    songFetcher.putAt(setSongDetails.currentSongKey!, model);
                                    debugPrint("Added to Favourites $addToFavs");
                                    showFavouriteSnackBar(
                                        context: context, isFavourite: addToFavs);
                                  },
                                  icon: Icon(CupertinoIcons.heart,
                                      color: songData!.isFavourited
                                          ? Colors.red
                                          : Colors.black87),
                                ),

                                const SizedBox(
                                  width: 80,
                                ),

                                Expanded(child: Text(songData.title!,style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),

                                // PopupMenuButton(
                                //   icon: const Icon(Icons.more_horiz,color: Colors.black,),
                                //   onSelected: (result) {
                                //     if (result == 1) {
                                //       showPlaylistNames(
                                //           context, setSongDetails.currentSongKey, songData.title);
                                //     } else {
                                //       showPlaylistNameToRemove(
                                //           context, songData.title);
                                //     }
                                //   },
                                //   itemBuilder: (context) => [
                                //     const PopupMenuItem(
                                //       child: Text("Add to Playlist"),
                                //       value: 1,
                                //     ),
                                //     const PopupMenuItem(
                                //       child: Text("Remove from Playlist"),
                                //       value: 2,
                                //     )
                                //   ],
                                // ),

                              ],
                            ),
                            Text(songData.artist!,style: const TextStyle(fontWeight: FontWeight.bold)),

                            setSongDetails.slider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: setSongDetails.getDuration(),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: setSongDetails.totalDuration(),
                                )
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.shuffle)),
                                IconButton(
                                  onPressed: () {
                                    setSongDetails.prev();
                                  },
                                  icon: const Icon(Icons.skip_previous),
                                  iconSize: 40.0,
                                ),

                                IconButton(
                                  onPressed: () {
                                    debugPrint(
                                        "\n-------------------Playing\n------------------");
                                    setSongDetails.playOrpause();
                                  },
                                  icon: setSongDetails.isIconChanged
                                      ? const Icon(Icons.pause)
                                      : const Icon(Icons.play_arrow),
                                  iconSize: 70.0,
                                ),
                                // btnStart(),

                                IconButton(
                                  onPressed: () {
                                    setSongDetails.next();
                                  },
                                  icon: const Icon(Icons.skip_next),
                                  iconSize: 40.0,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setSongDetails.loopSongs();
                                  },
                                  icon: setSongDetails.loopIcon == 1
                                      ? const Icon(
                                    Typicons.loop,
                                    size: 26,
                                    color: Colors.blueAccent,
                                  )
                                      : setSongDetails.loopIcon == 2
                                      ? const Icon(
                                    Icons.playlist_play_outlined,
                                    size: 26,
                                    color: Colors.blueAccent,
                                  )
                                      : const Icon(
                                    Icons.loop_outlined,
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),

                            // previous typed design

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     // IconButton(onPressed: (){
                            //     //   setState(() {
                            //     //     audioPlayer.play();
                            //     //
                            //     //     play = !play;
                            //     //   });
                            //     // }, icon: Icon((play == true)? Icons.play_circle_outlined : Icons.pause_circle_outlined,),iconSize: 80.0,
                            //     // ),
                            //     // IconButton(onPressed: (){}, icon: const Icon(Icons.pause_circle_outlined),iconSize: 80.0,),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        color: Colors.grey,
        child: Image.asset(
          urlImage,
          fit: BoxFit.cover,
        ),
      );

  @override
  void dispose() {
    // TODO: implement dispose
    // audioPlayer.dispose();
    super.dispose();
  }

// void next() {
//   setState(() {
//
//   });
//   audioPlayer.next();
//   controller.nextPage(duration: const Duration(milliseconds: 500));
// }
//
// void previous() {
//   setState(() {
//
//   });
//   audioPlayer.previous();
//   controller.previousPage(duration: const Duration(milliseconds: 500));
//
// }
//
// void seekToSec(int seconds) {
//   Duration newPosition = Duration(seconds: seconds);
//   audioPlayer.seek(newPosition);
// }

}
