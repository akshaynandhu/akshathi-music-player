import 'package:akshathi/home.dart';
import 'package:flutter/material.dart';

class Playlist1 extends StatefulWidget {
  const Playlist1({Key? key}) : super(key: key);

  @override
  State<Playlist1> createState() => _Playlist1State();
}

class _Playlist1State extends State<Playlist1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'PLAYLIST NAME',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  child: const Image(
                    image: NetworkImage(
                        'https://pbs.twimg.com/media/ETiDboWWoAE_xSY?format=jpg&name=small'),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.play_circle_outlined,
                    size: 35.0,
                    color: Colors.white,
                  ),
        PopupMenuButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 35.0,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Add Songs')),
              const PopupMenuItem(child: Text('Delete Playlist')),
            ]),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListTile(
                  onTap: () {

                  },
                  leading:
                      const Image(image: AssetImage('assets/images/now.png')),
                  title: const Text(
                    'Blinding Lights',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'The Weekend',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                },
                leading:
                    const Image(image: AssetImage('assets/images/now.png')),
                title: const Text(
                  'Blinding Lights',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'The Weekend',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ),
              ListTile(
                onTap: () {
                },
                leading:
                    const Image(image: AssetImage('assets/images/now.png')),
                title: const Text(
                  'Blinding Lights',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'The Weekend',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ),
              ListTile(
                onTap: () {
                },
                leading:
                    const Image(image: AssetImage('assets/images/now.png')),
                title: const Text(
                  'Blinding Lights',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'The Weekend',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ),
              ListTile(
                onTap: () {
                },
                leading:
                    const Image(image: AssetImage('assets/images/now.png')),
                title: const Text(
                  'Blinding Lights',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'The Weekend',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ),
              ListTile(
                onTap: () {
                },
                leading:
                    const Image(image: AssetImage('assets/images/now.png')),
                title: const Text(
                  'Blinding Lights',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'The Weekend',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ),
              ListTile(
                onTap: () {
                },
                leading:
                    const Image(image: AssetImage('assets/images/now.png')),
                title: const Text(
                  'Blinding Lights',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'The Weekend',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
