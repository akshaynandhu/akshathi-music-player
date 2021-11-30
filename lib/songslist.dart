import 'package:akshathi/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:marquee/marquee.dart';
import 'package:fluttericon/font_awesome_icons.dart';


import 'assetaudio.dart';
import 'main.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Box<QuerySongs>? songDetailsBox;

  bool click = true;


  @override
  void initState() {
    songDetailsBox = Hive.box<QuerySongs>(songDetailListBoxName);


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerItems>(
        builder: (context, songDetailsProvider, child) {
          return Offstage(
            offstage: songDetailsProvider.isSelectedOrNot,
            child: ValueListenableBuilder(
              valueListenable: songDetailsBox!.listenable(),
              builder: (context, Box<QuerySongs> songFetcher, _) {
                List keys = [];
                if (songDetailsProvider.modeOfPlaylist == 1) {
                  keys = songDetailsBox!.keys.cast<int>().toList();
                }
                songDetailsProvider.currentSongKey =
                keys[songDetailsProvider.selectedSongKey ?? 0];
                var songData =
                songFetcher.get(songDetailsProvider.currentSongKey);

                if (songFetcher.isEmpty) {
                  return const Center(
                    child: Text("No Data Available"),
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          tileColor: Colors.white38,
                          isThreeLine: true,
                          leading: QueryArtworkWidget(
                            id: songData?.imageId ?? 0,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget:
                              Icon(Icons.music_note),
                            // Image.asset("assets/images/defaultImage.png"),
                            // artworkWidth: 200,
                          ),
                          title: commonMarquees(
                              text: songData?.title,
                              hPadding: 0.0,
                              size: 13.0,
                              height: 25.0
                          ),
                          subtitle: commonMarquees(
                              text: songData?.artist,
                              hPadding: 0.0,
                              size: 11.0,
                              height: 25.0
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  debugPrint("Previous Icon Clicked");
                                  songDetailsProvider.prev();
                                },
                                icon: const Icon(FontAwesome.left_dir),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                songDetailsProvider.playOrpause();
                              },
                              icon: songDetailsProvider.isIconChanged
                                  ? const Icon(
                                Icons.pause,
                                size: 32,
                              )
                                  : const Icon(
                                Icons.play_arrow,
                                size: 32,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                debugPrint("Next Icon Pressed");
                                songDetailsProvider.next();
                              },
                              icon: const Icon(FontAwesome.right_dir),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          );
        }
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

  commonMarquees(
      {height, width, hPadding, vPadding, text = "", velocity, blankSpace, color, weight, size, family, duration}) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? 40.0, vertical: vPadding ?? 0.0,),
        child: Marquee(
          text: text ?? "Not Found",
          blankSpace: blankSpace ?? 300,
          numberOfRounds: 1,
          velocity: velocity ?? 30,
          pauseAfterRound: Duration(seconds: duration ?? 3),
          style: style(color: color ?? Colors.black,
              weight: weight ?? FontWeight.w700,
              size: size,
              family: family ?? "Poppins-Regular"),
        ),
      ),
    );
  }

}
