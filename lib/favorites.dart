import 'package:akshathi/model/data_model.dart';
import 'package:akshathi/provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'music.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  Box<QuerySongs>? userSongDbInstance;
  List<String> songsPaths =[];
  @override
  void initState() {
    userSongDbInstance = Hive.box<QuerySongs>(songDetailListBoxName);
    getSongPathsMan();
    super.initState();
  }

  getSongPathsMan(){
    final pInstance = Provider.of<PlayerItems>(context, listen: false);
    if(pInstance.favPlaylist.isEmpty){
      for (var element in userSongDbInstance!.values) {
        if(element.isFavourited == true){
          songsPaths.add(element.songPath!);
        }
      }
    }
    pInstance.showKeys();
    debugPrint("Favourites Done");
  }

  changeModeOfPlay(){
    final pInstance = Provider.of<PlayerItems>(context, listen: false);
    pInstance.getFavSongsPaths(songsPaths);
    pInstance.modeOfPlaylist = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ListView(
            children: [
              const Text(
                'Favorites',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              favouriteSongs(),
            ],
          ),
          // const CommonMiniPlayer(),
        ],
      ),
    );
  }

  favouriteSongs() {
    return Consumer<PlayerItems>(
      builder: (_, setSongDetails, child) => ValueListenableBuilder(
        valueListenable: userSongDbInstance!.listenable(),
        builder: (context, Box<QuerySongs> songFetcher, _) {
          List<int> keys = songFetcher.keys.cast<int>().where((key) => songFetcher.get(key)!.isFavourited == true).toList();

          if (songFetcher.isEmpty) {
            return Column(
              children: const [
                Text("No Songs So Far...",style: TextStyle(color: Colors.white),),
              ],
            );
          } else {
            return ListView.builder(
              itemCount: keys.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                final key = keys[index];
                final songDatas = songFetcher.get(key);
                return GestureDetector(
                  onTap: () {
                    // setSongDetails.isFavsAlreadyClicked = true;
                    changeModeOfPlay();
                    // setSongDetails.isAllSongsAlreadyClicked = false;
                    setSongDetails.isSelectedOrNot = false;
                    setSongDetails.selectedSongKey = index;
                    setSongDetails.opnPlaylist(setSongDetails.selectedSongKey);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Nowplaying()));
                  },
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: QueryArtworkWidget(
                          id: songDatas!.imageId!,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipRRect(
                              child: Image.asset(
                                "assets/images/song1.png",
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
                      padding: const EdgeInsets.only(top: 8,bottom: 5),
                      child:
                      Text(
                        songDatas.title.toString(),style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child:
                      Text(
                        songDatas.artist.toString(),
                        style:  TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),

                      )
                    ),
                    trailing: SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                final model = QuerySongs(title: songDatas.title,artist: songDatas.artist,songPath: songDatas.songPath,isFavourited: false,isAddedtoPlaylist: false,imageId: songDatas.imageId,duration: songDatas.duration);
                                songFetcher.put(key, model);
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


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     body: SingleChildScrollView(
  //       child: SafeArea(
  //         child: Column(
  //           children: [
  //             Container(
  //               child: image,
  //             ),
  //
  //              Padding(
  //               padding: const EdgeInsets.only(top: 20.0),
  //               child: ListTile(
  //                 onTap: (){
  //                   showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
  //                 },
  //                 leading: const Image(image: AssetImage('assets/images/now.png')),
  //                 title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
  //                 subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
  //                 trailing: const Icon(Icons.delete_sweep,color: Colors.white,),
  //               ),
  //             ),
  //              ListTile(
  //                onTap: (){
  //                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
  //                },
  //               leading: const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
  //               subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
  //               trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
  //              ListTile(
  //                onTap: (){
  //                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
  //                },
  //               leading: const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
  //               subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
  //               trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
  //              ListTile(
  //                onTap: (){
  //                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
  //                },
  //               leading: const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
  //               subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
  //               trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
  //              ListTile(
  //                onTap: (){
  //                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
  //                },
  //               leading: const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
  //               subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
  //               trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
  //              ListTile(
  //                onTap: (){
  //                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
  //                },
  //               leading: const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
  //               subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
  //               trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
  //              ListTile(
  //               onTap: (){
  //                 showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
  //               },
  //               leading: const Image(image: AssetImage('assets/images/now.png')),
  //               title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
  //               subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
  //               trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
  //           ],
  //         ),),
  //     )
  //     ,
  //   );
  // }
  //
  // Widget get image {
  //   return const ClipRRect(
  //       borderRadius: BorderRadius.only(
  //         bottomRight: Radius.circular(60),
  //         bottomLeft: Radius.circular(60),
  //       ),
  //       child: Image(
  //         image: AssetImage('assets/images/love.jpg'),
  //       ),
  //   );
  // }
  //
  // Widget PopupDialog(BuildContext context) {
  //   return AlertDialog(
  //     backgroundColor: Colors.white,
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: const [
  //         Icon(Icons.delete_sweep,color: Colors.black,),
  //         Text("Removed",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
  //       ],
  //     ),
  //   );
  // }

}
