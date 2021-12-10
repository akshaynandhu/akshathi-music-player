import 'package:akshathi/main.dart';
import 'package:akshathi/provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'model/data_model.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  Box<QuerySongs>? querysongs;

  @override
  void initState() {
    querysongs = Hive.box<QuerySongs>(songDetailListBoxName);
    super.initState();
  }

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerItems>(
        builder: (_,setSongDetails,child)=>GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black
                  ),
                  child: Row(
                    children: [

                      Expanded(child: TextFormField(
                        onChanged: (a){
                          setSongDetails.onSearchChanged(searchController);
                        },
                        controller: searchController,
                        decoration: const InputDecoration.collapsed(hintText: "Search your songs here",hintStyle:TextStyle(color: Colors.grey,fontSize: 20),),style: TextStyle(color: Colors.white),
                      )),
                      const Icon(Icons.search,
                        size: 20,
                        color: Colors.grey,),
                    ],
                  ),
                ),
                songList(),
              ],
            ),
          ),
        )
    );
  }

  Widget songList(){
    return Consumer<PlayerItems>(
      builder: (_,setSongDetails,child)=> ValueListenableBuilder(
          valueListenable: querysongs!.listenable(), builder: (context,Box<QuerySongs> songFetcher,_){
            var results = searchController.text.isEmpty
                ? songFetcher.values.toList()
                : songFetcher.values
                .where((element) => element.title!.toLowerCase().contains(setSongDetails.searchSongName)).toList();

            // debugPrint("Value of Provider inside ValueListenableBuilder is ${setSongDetails.searchSongName}");

        return results.isEmpty
            ? const Center(
          child: Text(
            'Nothing Found',
            style: TextStyle(color: Colors.red),
          ),
        )
        :ListView.builder(itemCount: results.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context,index){
          final QuerySongs contactListItem = results[index];

          return GestureDetector(
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: QueryArtworkWidget(id: contactListItem.imageId!, type: ArtworkType.AUDIO,
                nullArtworkWidget: ClipRRect(
                  child: Image.asset('assets/images/songsnew.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,),
                  borderRadius: BorderRadius.circular(10),
                ),
                  artworkBorder: BorderRadius.circular(10),
                  artworkHeight: 50,
                  artworkWidth: 50,
                  artworkFit: BoxFit.fill,
                ),
              ),
              title: Text(
                contactListItem.title.toString(),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.red),
              ),
              subtitle: Text(
                contactListItem.artist.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),
              ),
            ),
          );
        },);
      }),
    );
  }

}
