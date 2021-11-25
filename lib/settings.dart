import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  bool noti = false;

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(children: <Widget>[
                  const Padding(
                    padding:  EdgeInsets.all(20.0),
                    child: Text('SETTINGS',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),textAlign: TextAlign.center,),
                  ),

                  const SizedBox(height: 20,),

                  ListTile(
                    title: const Text(
                      'Share',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    leading: const Icon(
                      Icons.share,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    onTap: () {
                      /* Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => dealerBuilder()));*/
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Privacy Policies',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    leading: const Icon(
                      Icons.policy,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    onTap: () {
                      /*Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => shufflerBuilder()));*/
                    },
                  ),

                  
                  ListTile(
                    title: const Text(
                      'Terms & Conditions',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    leading: const Icon(
                      Icons.gavel,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    onTap: () {
                      /* Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => mistakePage()));*/
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'About',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    leading: const Icon(
                      Icons.extension,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    onTap: () {
                      showAboutDialog(context: context,
                      applicationName: 'Music App',
                        applicationIcon: const Icon(Icons.music_note),
                        children: [
                          const Text("Music is more than simply pressing play. Welcome to Resso, a new music app that lets you express yourself and connect, through the tracks you love and the ones you're about to discover.")
                        ]
                      );
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),

                  SwitchListTile(
                    title:
                    Text('Notification',style: TextStyle(fontSize: 18.0, color: Colors.white),),
                    onChanged: (bool newValue) => setState(() {
                       noti = newValue;
                    }),
                    value: noti,

                  ),

                ]),
              ),
              Container(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text('Version 2.0.0',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
