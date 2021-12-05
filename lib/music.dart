import 'package:akshathi/provider.dart';
import 'package:akshathi/model/data_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    // songFetcher.putAt(key, model);
                                    debugPrint("Added to Favourites $addToFavs");
                                    showFavouriteSnackBar(
                                        context: context, isFavourite: addToFavs);
                                  },
                                  icon: Icon(CupertinoIcons.heart,
                                      color: songData!.isFavourited
                                          ? Colors.red
                                          : Colors.black87),
                                ),

                                // IconButton(
                                //   onPressed: () {
                                //     setState(() {
                                //       click = !click;
                                //     });
                                //   },
                                //   icon: Icon(
                                //     (click == true)
                                //         ? Icons.favorite_border
                                //         : Icons.favorite,
                                //   ),
                                // ),
                                Expanded(child: Center(child: Text(songData.title!,style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),))),

                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add)),
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

                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 20),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //
                            //       getDuration(),
                            //       totalDuration(),
                            //
                            //     ],
                            //   ),
                            // ),

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
                                    onPressed: () {},
                                    icon: const Icon(Icons.repeat)),
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
