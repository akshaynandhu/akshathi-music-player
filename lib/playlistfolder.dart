import 'package:akshathi/provider.dart';
import 'package:akshathi/home.dart';
import 'package:akshathi/model/data_model.dart';
import 'package:akshathi/music.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'newplaylist.dart';

class PlaylistSong extends StatefulWidget {
   PlaylistSong({this.selectedPlaylistKey});

  int? selectedPlaylistKey;


  @override
  State<PlaylistSong> createState() => _PlaylistSongState();
}

class _PlaylistSongState extends State<PlaylistSong> {

  Box<PlaylistSongs>? playlistSongInstance;
  Box<NewPlaylistName>? playlistNameInstance;

  List<String> songsPath=[];

@override
  void initState() {

  playlistSongInstance = Hive.box<PlaylistSongs>(newPlaylistSongBoxName);

  playlistNameInstance = Hive.box<NewPlaylistName>(newPlaylistBoxName);

  final providerInstance = Provider.of<PlayerItems>(context,listen:false);

  songPath();
  debugPrint("Path in AudioPlayer is ");
  providerInstance.showKeys();
  debugPrint("Playlist Songs Done");

  super.initState();
  }

  songPath(){
    final providerInstance = Provider.of<PlayerItems>(context,listen:false);

    var data = playlistNameInstance!.get(widget.selectedPlaylistKey);
    debugPrint(data?.playlistName.toString().toUpperCase());
    if(providerInstance.playlistSongsPlaylist.isEmpty){
      for (var element in playlistSongInstance!.values) {
        if(widget.selectedPlaylistKey == element.currespondingPlaylistId){
          debugPrint(element.songName);
          songsPath.add(element.songPath??'');
          providerInstance.alreadyPlayingPlaylistIndex = element.currespondingPlaylistId!;

          debugPrint(element.songPath);

          debugPrint("FIrst Key isssss   ----- ${element.currespondingPlaylistId}");

        }
      }

    }else{
      if(providerInstance.alreadyPlayingPlaylistIndex != widget.selectedPlaylistKey ){
        debugPrint("Entered ");
        providerInstance.playlistSongsPlaylist.clear();
        debugPrint("Emptied");
        debugPrint("AlreadyPlaying Key is ${providerInstance.alreadyPlayingPlaylistIndex}");
        debugPrint("Selected Key is ${widget.selectedPlaylistKey}");
        for (var element in playlistSongInstance!.values) {
          if(element.currespondingPlaylistId == widget.selectedPlaylistKey){
            songsPath.add(element.songPath!);
            debugPrint(element.songPath);
          }
        }
        providerInstance.alreadyPlayingPlaylistIndex = widget.selectedPlaylistKey!;
        debugPrint("ALreadY Key nOW IS ${providerInstance.alreadyPlayingPlaylistIndex}");
      }
    }
  }

  commonText(
      {text,
        color = Colors.white,
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

  changePlaylistMode(){
    final providerInstance = Provider.of<PlayerItems>(context,listen: false);
    providerInstance.getPlaylistSongsPaths(songsPath);
    providerInstance.test = widget.selectedPlaylistKey!;
    providerInstance.modeOfPlaylist = 3;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              ValueListenableBuilder(
                  valueListenable: playlistNameInstance!.listenable(),
                  builder: (context, Box<NewPlaylistName>playlistNameFetcher,
                      _) {
                    List<int> keys = playlistSongInstance!.keys.cast<int>()
                        .where((key) =>
                    playlistSongInstance!.get(key)!.currespondingPlaylistId ==
                        widget.selectedPlaylistKey)
                        .toList();
                    final songData = playlistNameFetcher.get(
                        widget.selectedPlaylistKey);
                    return SizedBox(
                      width: 180,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.chevron_left_outlined, size: 27,color: Colors.white),),
                                  commonText(text: songData?.playlistName),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Newplaylist(playlistName: songData!.playlistName,playlistKey: widget.selectedPlaylistKey,)));
                                    },
                                    icon: const Icon(Icons.add,color: Colors.white),
                                    tooltip: "Add More",
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      playlistSongInstance!.deleteAll(keys);
                                      playlistNameFetcher.delete(
                                          widget.selectedPlaylistKey);
                                      var providerInstance = Provider.of<PlayerItems>(context,listen: false);
                                      providerInstance.isSelectedOrNot = true;
                                    },
                                    icon: const Icon(Icons.delete,color: Colors.white,),
                                    tooltip: "Delete Playlist",
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              ),
              const SizedBox(
                height: 20,
              ),
              playlistSongTileView(context),
            ],
          ),

        ],
      ),
    );
  }

  playlistSongTileView(BuildContext context) {
    return Consumer<PlayerItems>(
      builder: (_, setSongDetails, child) =>ValueListenableBuilder(
        valueListenable: playlistSongInstance!.listenable(),
        builder: (context, Box<PlaylistSongs> songFetcher, _) {
          List<int> keys = songFetcher.keys.cast<int>()
              .where((key) =>
          songFetcher.get(key)!.currespondingPlaylistId ==
              widget.selectedPlaylistKey)
              .toList();
          if (songFetcher.isEmpty) {
            return Column(
              children: const [
                Text("No Songs So Far..."),
              ],
            );
          } else {
            return ListView.builder(
              itemCount: keys.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                final key = keys[index];
                final songData = songFetcher.get(key);
                return GestureDetector(
                  onTap: () {
                    changePlaylistMode();
                    setSongDetails.isAudioPlayingFromPlaylist = true;
                    setSongDetails.isSelectedOrNot = false;
                    setSongDetails.selectedSongKey = index;
                    setSongDetails.opnPlaylist(setSongDetails.selectedSongKey);
                    print(index);
                  },
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: QueryArtworkWidget(
                          id: songData!.songImageId!,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipRRect(
                              child: Image.asset(
                                "assets/images/song1.jpg",
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
                      child:  Text(
                          songData.songName.toString(),
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child:Text(songData.artistName.toString(),style:
                      const TextStyle(
                        color: Colors.white
                      ),),
                    ),
                    trailing: SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: const Icon(
                                CupertinoIcons.minus_circled,color: Colors.red,
                              ),
                              onPressed: () {
                                debugPrint("Delete Item Key is $key");
                                songFetcher.delete(key);
                                debugPrint("Delete Button Clicked");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }



  //Demo UI

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       automaticallyImplyLeading: false,
  //       leading: IconButton(
  //         onPressed: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => Home()));
  //         },
  //         icon: const Icon(
  //           Icons.arrow_back_ios_outlined,
  //           color: Colors.white,
  //         ),
  //       ),
  //       backgroundColor: Colors.black,
  //       title: const Text(
  //         'PLAYLIST NAME',
  //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  //       ),
  //       centerTitle: true,
  //     ),
  //     backgroundColor: Colors.black,
  //     body: SingleChildScrollView(
  //       child: SafeArea(
  //         child: Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(30.0),
  //               child: Container(
  //                 child: const Image(
  //                   image: NetworkImage(
  //                       'https://pbs.twimg.com/media/ETiDboWWoAE_xSY?format=jpg&name=small'),
  //                 ),
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 const Icon(
  //                   Icons.play_circle_outlined,
  //                   size: 35.0,
  //                   color: Colors.white,
  //                 ),
  //       PopupMenuButton(
  //           icon: const Icon(
  //             Icons.more_horiz,
  //             color: Colors.white,
  //             size: 35.0,
  //           ),
  //           itemBuilder: (context) => [
  //             const PopupMenuItem(child: Text('Add Songs')),
  //             const PopupMenuItem(child: Text('Delete Playlist')),
  //           ]),
  //               ],
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 20.0),
  //               child: ListTile(
  //                 onTap: () {
  //
  //                 },
  //                 leading:
  //                     const Image(image: AssetImage('assets/images/now.png')),
  //                 title: const Text(
  //                   'Blinding Lights',
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //                 subtitle: const Text(
  //                   'The Weekend',
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //                 trailing: const Icon(
  //                   Icons.keyboard_arrow_down,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //             ListTile(
  //               onTap: () {
  //               },
  //               leading:
  //                   const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text(
  //                 'Blinding Lights',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               subtitle: const Text(
  //                 'The Weekend',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               trailing: const Icon(
  //                 Icons.keyboard_arrow_down,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             ListTile(
  //               onTap: () {
  //               },
  //               leading:
  //                   const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text(
  //                 'Blinding Lights',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               subtitle: const Text(
  //                 'The Weekend',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               trailing: const Icon(
  //                 Icons.keyboard_arrow_down,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             ListTile(
  //               onTap: () {
  //               },
  //               leading:
  //                   const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text(
  //                 'Blinding Lights',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               subtitle: const Text(
  //                 'The Weekend',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               trailing: const Icon(
  //                 Icons.keyboard_arrow_down,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             ListTile(
  //               onTap: () {
  //               },
  //               leading:
  //                   const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text(
  //                 'Blinding Lights',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               subtitle: const Text(
  //                 'The Weekend',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               trailing: const Icon(
  //                 Icons.keyboard_arrow_down,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             ListTile(
  //               onTap: () {
  //               },
  //               leading:
  //                   const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text(
  //                 'Blinding Lights',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               subtitle: const Text(
  //                 'The Weekend',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               trailing: const Icon(
  //                 Icons.keyboard_arrow_down,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             ListTile(
  //               onTap: () {
  //               },
  //               leading:
  //                   const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text(
  //                 'Blinding Lights',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               subtitle: const Text(
  //                 'The Weekend',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               trailing: const Icon(
  //                 Icons.keyboard_arrow_down,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
