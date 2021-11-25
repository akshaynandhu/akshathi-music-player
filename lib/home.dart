import 'package:akshathi/favorites.dart';
import 'package:akshathi/music.dart';
import 'package:akshathi/nowplaying.dart';
import 'package:akshathi/playlist.dart';
import 'package:akshathi/settings.dart';
import 'package:akshathi/songs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isPlaying=false;
  bool isPaused=false;

  final List<IconData> _icons =[
    Icons.play_arrow,
    Icons.pause,
  ];

  Widget btnStart(){
    return IconButton(
        iconSize: 35,
        onPressed: (){
          if(isPlaying==false) {
            audioPlayer.play();
            setState(() {
              isPlaying = true;
            });
          }else if(isPlaying==true){
            audioPlayer.pause();
            setState(() {
              isPlaying=false;
            });
          }
        },
        icon: isPlaying==false?Icon(_icons[0]):Icon(_icons[1]));
  }

  @override
  Widget build(BuildContext context) {

    // final screenwidth = MediaQuery.of(context).size.width;


    return Scaffold(
      endDrawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Music App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.only(right: 290.0, top: 40, left: 45.0),
                      child: Icon(
                        Icons.music_note,
                        color: Colors.red,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50.0, top: 10.0),
                      child: Text(
                        'Now Playing',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Nowplaying()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0,right: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 5,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: ListTile(
                            isThreeLine: true,
                            leading: const Image(image: AssetImage('assets/images/song1.jpg')),
                            title: const Text("Darshana",style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Hridayam"),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:  [

                                    IconButton(
                                      onPressed: previous,
                                      icon: Icon(Icons.skip_previous),
                                      iconSize: 30.0,
                                    ),

                                    btnStart(),

                                    IconButton(
                                      onPressed: next,
                                      icon: Icon(Icons.skip_next),
                                      iconSize: 30.0,
                                    ),

                                    // Icon(Icons.fast_rewind),
                                    // Icon(Icons.pause_outlined,size: 30,),
                                    // Icon(Icons.fast_forward),
                                  ],
                                )
                              ],
                            ),
                            trailing: const Icon(Icons.radio),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                constraints: const BoxConstraints(
                    minWidth: 420,
                    maxWidth: 420,
                    minHeight: 280,
                    maxHeight: 280),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'FOR YOU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'SONGS',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Songs()))
                  },
                ),
                ListTile(
                  title: const Text(
                    'PLAYLIST',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Playlist()))
                  },
                ),
                ListTile(
                  title: const Text(
                    'FAVORITES',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Favorites()))
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  void next() {
    setState(() {

    });
    audioPlayer.next();
    controller.nextPage(duration: const Duration(milliseconds: 500));
  }

  void previous() {
    setState(() {

    });
    audioPlayer.previous();
    controller.previousPage(duration: const Duration(milliseconds: 500));

  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(60),
        topLeft: Radius.circular(60),
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Favorites()));
                  },
                  icon: const Icon(Icons.favorite_border)),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.headphones)),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Songs()));
                  },
                  icon: const Icon(Icons.search)),
              label: ''),
        ],
        currentIndex: 1,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}
