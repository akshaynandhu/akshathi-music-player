import 'package:flutter/material.dart';

class Songs extends StatefulWidget {
  const Songs({Key? key}) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                child: image,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'SONGS',
                  style: TextStyle(color: Colors.white, fontSize: 25),
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
                    hintText: 'search',
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              ListTile(
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
                trailing: PopupMenuButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(child: Text('Add to favorites')),
                          const PopupMenuItem(child: Text('Add to Playlist')),
                        ]),
              ),
              ListTile(
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
                trailing: PopupMenuButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(child: Text('Add to favorites')),
                          const PopupMenuItem(child: Text('Add to Playlist')),
                        ]),
              ),
              ListTile(
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
                trailing: PopupMenuButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(child: Text('Add to favorites')),
                          const PopupMenuItem(child: Text('Add to Playlist')),
                        ]),
              ),
              ListTile(
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
                trailing: PopupMenuButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(child: Text('Add to favorites')),
                          const PopupMenuItem(child: Text('Add to Playlist')),
                        ]),
              ),
              ListTile(
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
                trailing: PopupMenuButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(child: Text('Add to favorites')),
                          const PopupMenuItem(child: Text('Add to Playlist')),
                        ]),
              ),
              ListTile(
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
                trailing: PopupMenuButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(child: Text('Add to favorites')),
                          const PopupMenuItem(child: Text('Add to Playlist')),
                        ]),
              ),
              ListTile(
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
                trailing: PopupMenuButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(child: Text('Add to favorites')),
                          const PopupMenuItem(child: Text('Add to Playlist')),
                        ]),
              ),
              ListTile(
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
                trailing: PopupMenuButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(child: Text('Add to favorites')),
                          const PopupMenuItem(child: Text('Add to Playlist')),
                        ]),
              ),
            ],
          ),
        ),
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
