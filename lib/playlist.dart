import 'package:akshathi/favorites.dart';
import 'package:akshathi/main.dart';
import 'package:akshathi/model/data_model.dart';
import 'package:akshathi/newplaylist.dart';
import 'package:akshathi/playlistfolder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Box<NewPlaylistName>? newPlaylistNameDbInstance;
  Box<PlaylistSongs>? newPlaylistSongs;


  final newPlaylistName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorMessage = "Name Required";
  List userPlaylistNames = [];



  @override
  void initState() {

    newPlaylistNameDbInstance = Hive.box<NewPlaylistName>(newPlaylistBoxName);
    newPlaylistSongs =Hive.box<PlaylistSongs>(newPlaylistSongBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'PLAYLIST',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Favorites()));
                },
                child: const Text(
                  'Favourites',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(380, 50), primary: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                    'My Playlists',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),


            playListFolder(context),

            //Demo playlists

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const Playlist1()));
            //       },
            //       child: Image.asset(
            //         'assets/images/now.png',
            //         scale: 3,
            //         fit: BoxFit.fill,
            //       ),
            //       style: ElevatedButton.styleFrom(
            //           fixedSize: const Size(110, 110), primary: Colors.white),
            //     ),
            //
            //     const SizedBox(
            //       width: 10,
            //     ),
            //
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Image.asset(
            //         'assets/images/now.png',
            //         scale: 3,
            //         fit: BoxFit.fill,
            //       ),
            //       style: ElevatedButton.styleFrom(
            //           fixedSize: const Size(110, 110), primary: Colors.white),
            //     ),
            //
            //     const SizedBox(
            //       width: 10,
            //     ),
            //
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Image.asset(
            //         'assets/images/now.png',
            //         scale: 3,
            //         fit: BoxFit.fill,
            //       ),
            //       style: ElevatedButton.styleFrom(
            //           fixedSize: const Size(110, 110), primary: Colors.white),
            //     ),
            //
            //   ],
            // ),
            //
            // const SizedBox(
            //   height: 20,
            // ),
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Image.asset(
            //         'assets/images/now.png',
            //         scale: 3,
            //         fit: BoxFit.fill,
            //       ),
            //       style: ElevatedButton.styleFrom(
            //           fixedSize: const Size(110, 110), primary: Colors.white),
            //     ),
            //
            //     const SizedBox(
            //       width: 10,
            //     ),
            //
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Image.asset(
            //         'assets/images/now.png',
            //         scale: 3,
            //         fit: BoxFit.fill,
            //       ),
            //       style: ElevatedButton.styleFrom(
            //           fixedSize: const Size(110, 110), primary: Colors.white),
            //     ),
            //
            //     const SizedBox(
            //       width: 10,
            //     ),
            //
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Image.asset(
            //         'assets/images/now.png',
            //         scale: 3,
            //         fit: BoxFit.fill,
            //       ),
            //       style: ElevatedButton.styleFrom(
            //           fixedSize: const Size(110, 110), primary: Colors.white),
            //     ),
            //
            //   ],
            // ),
            //
            // const SizedBox(
            //   height: 20,
            // ),
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Image.asset(
            //         'assets/images/now.png',
            //         scale: 3,
            //         fit: BoxFit.fill,
            //       ),
            //       style: ElevatedButton.styleFrom(
            //           fixedSize: const Size(110, 110), primary: Colors.white),
            //     ),
            //
            //     const SizedBox(
            //       width: 10,
            //     ),
            //
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Image.asset(
            //         'assets/images/now.png',
            //         scale: 3,
            //         fit: BoxFit.fill,
            //       ),
            //       style: ElevatedButton.styleFrom(
            //           fixedSize: const Size(110, 110), primary: Colors.white),
            //     ),
            //
            //   ],
            // ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){
          setState((){
            createPlaylist(context);
          });
        },
        child: const Icon(Icons.add,size: 35,color: Colors.black,),
      ),
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

  createPlaylist(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "New Playlist",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white
            ),
          ),
          content: SizedBox(
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: newPlaylistName,
                        decoration: const InputDecoration.collapsed(
                            hintText: "Playlist Name",hintStyle: TextStyle(color: Colors.grey)),
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        validator: (playlistName) {
                          if (playlistName!.isEmpty) {
                            return errorMessage;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel',style: TextStyle(fontSize: 15,color: Colors.purple,fontWeight: FontWeight.bold),)
                    ),
                    MaterialButton(
                      onPressed: () {
                        createNewPlaylist();
                        debugPrint("Playlist Created");
                        newPlaylistName.clear();
                      },
                      child: const Text('Create',style: TextStyle(fontSize: 15,color: Colors.purple,fontWeight: FontWeight.bold),)
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  deleteOnLongPress(currespondingKey,BuildContext context){
    List playlistSongsOfSelectedPlaylist = [];
    for (var element in newPlaylistSongs!.values) {
      if(element.currespondingPlaylistId == currespondingKey){
        playlistSongsOfSelectedPlaylist.add(element.currespondingPlaylistId);
      }
    }
    newPlaylistSongs!.deleteAll(playlistSongsOfSelectedPlaylist);
    newPlaylistNameDbInstance!.delete(currespondingKey);
    showFavouriteSnackBar(context: context,text: "Deleted",duration: 1);
  }

  bool didFound = false;
  createNewPlaylist() {
    if (formKey.currentState!.validate()) {
      for (var element in userPlaylistNames) {
        if(element == newPlaylistName.text){
          didFound = true;
        }
      }
      if(didFound == false){
        var newlyCreatedPlalistName = newPlaylistName.text;
        final model = NewPlaylistName(playlistName: newlyCreatedPlalistName);
        newPlaylistNameDbInstance!.add(model);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Newplaylist(
              playlistKey: newPlaylistNameDbInstance!.keys.last,
              playlistName: newlyCreatedPlalistName,
            ),
          ),
        );
      }else{
        debugPrint("POPPED");
        Navigator.of(context).pop();
        showFavouriteSnackBar(context: context,text:"Playlist Already exists, try with another name ");
      }
    }
  }

  showFavouriteSnackBar({required BuildContext context, text,duration}) {
    final snack = SnackBar(
      content:commonText(
          text: text,
          color: Colors.black,
          size: 13,
          weight: FontWeight.w500,
          isCenter: true),
      duration:  Duration(seconds: duration??3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.red,
      width: 100,
    );
    return ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  // createPlaylist(BuildContext context) {
  //   TextEditingController newPlaylistName = TextEditingController();
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.black,
  //         title: const Center(
  //           child:  Text(
  //             "New Playlist",
  //             style: TextStyle(
  //               fontSize: 25,
  //               color: Colors.white,
  //                 fontWeight: FontWeight.bold
  //             ),
  //           ),
  //         ),
  //         content: SizedBox(
  //           height: 80,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               TextFormField(
  //                 controller: newPlaylistName,
  //                 decoration:
  //                 const InputDecoration.collapsed(hintText: "Enter playlist name",hintStyle: TextStyle(color: Colors.grey),),
  //                 style: const TextStyle(color: Colors.white),
  //               ),
  //               const Divider(
  //                 height: 0.5,
  //                 color: Colors.purple,
  //                 thickness: 0.5,
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   MaterialButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child:  const Text('Cancel',style: TextStyle(fontSize: 15,color: Colors.purple,fontWeight: FontWeight.bold),)
  //                   ),
  //                   MaterialButton(
  //                     onPressed: () {
  //                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> const Newplaylist()));
  //                       final model = NewPlaylistName(playlistName: newPlaylistName.text);
  //                       newPlaylistNameDbInstance!.add(model);
  //                       // newPlaylistNameDbInstance!.values.forEach((element) {
  //                       //   debugPrint(element.playlistName);
  //                       // });
  //                       Navigator.pop(context);
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => Newplaylist(playlistKey: newPlaylistNameDbInstance!.keys.last,playlistName: newPlaylistName.text,)));
  //
  //                       debugPrint("Playlist Created $newPlaylistName");
  //                     },
  //                     child: const Text('Create',style: TextStyle(fontSize: 15,color: Colors.purple,fontWeight: FontWeight.bold),)
  //                   )
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  playListFolder(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: newPlaylistNameDbInstance!.listenable(),
        builder: (context,Box<NewPlaylistName> playlistNameFetcher,_){
          List<int> allKeys =
          playlistNameFetcher.keys.cast<int>().toList();
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.95 / 0.7,
                mainAxisSpacing: 32,
                crossAxisSpacing: 18),
            shrinkWrap: true,
            itemCount: allKeys.length,
            itemBuilder: (context, index) {
              final key = allKeys[index];
              final songData = playlistNameFetcher.get(key);
              return GestureDetector(
                onTap: () {
                  debugPrint("Index Curresponding to Playlist is $index");
                  debugPrint("Key Curresponding to Playlist is $key");
                  final pInstance = Provider.of<PlayerItems>(context,listen:false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PlaylistSong(selectedPlaylistKey: key,)));
                  debugPrint("Navigator to Playlist Clicked");                },
                child: Container(
                  child: Card(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${songData!.playlistName}", style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
                onLongPress: (){
                  deleteOnLongPress(key,context);
                },
              );
            },
          );
        }
    );
  }

  @override
  void dispose() {
    newPlaylistName.dispose();
    super.dispose();
  }

}
