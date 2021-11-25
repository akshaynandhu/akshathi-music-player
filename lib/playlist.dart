import 'package:akshathi/newplaylist.dart';
import 'package:akshathi/playlist1.dart';
import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
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
                showDialog(context: context, builder: (BuildContext context) => _buildPopupDialog(context));
              },
              child: const Text(
                '+ Create Playlist',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Playlist1()));
                },
                child: Image.asset(
                  'assets/images/now.png',
                  scale: 3,
                  fit: BoxFit.fill,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 110), primary: Colors.white),
              ),

              const SizedBox(
                width: 10,
              ),

              ElevatedButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/images/now.png',
                  scale: 3,
                  fit: BoxFit.fill,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 110), primary: Colors.white),
              ),

              const SizedBox(
                width: 10,
              ),

              ElevatedButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/images/now.png',
                  scale: 3,
                  fit: BoxFit.fill,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 110), primary: Colors.white),
              ),

            ],
          ),

          const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/images/now.png',
                  scale: 3,
                  fit: BoxFit.fill,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 110), primary: Colors.white),
              ),

              const SizedBox(
                width: 10,
              ),

              ElevatedButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/images/now.png',
                  scale: 3,
                  fit: BoxFit.fill,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 110), primary: Colors.white),
              ),

              const SizedBox(
                width: 10,
              ),

              ElevatedButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/images/now.png',
                  scale: 3,
                  fit: BoxFit.fill,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 110), primary: Colors.white),
              ),

            ],
          ),

          const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/images/now.png',
                  scale: 3,
                  fit: BoxFit.fill,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 110), primary: Colors.white),
              ),

              const SizedBox(
                width: 10,
              ),

              ElevatedButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/images/now.png',
                  scale: 3,
                  fit: BoxFit.fill,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 110), primary: Colors.white),
              ),

            ],
          ),

        ],
      ),
    );
  }


  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Playlist '),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Enter Playlist Name"),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Newplaylist()));
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Create'),
        ),
      ],
    );
  }


}
