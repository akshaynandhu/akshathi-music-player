import 'package:akshathi/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  late SharedPreferences changeNotificationSettings;
  bool turnNotificationOn = true;

  @override
  void initState() {
    initializeNotificationShared();
    getSharedPreference();
    super.initState();
  }

  initializeNotificationShared() async {
    changeNotificationSettings = await SharedPreferences.getInstance();
  }

  Future<void> getSharedPreference() async {
    var pInstance =
    Provider.of<PlayerItems>(context, listen: false);
    final sharedPref = await SharedPreferences.getInstance();
    turnNotificationOn = sharedPref.getBool('changeNotificationMode') ?? true;
    turnNotificationOn
        ? pInstance.disableNotification()
        : pInstance.enableNotification;
    pInstance.turnNotificationOn = turnNotificationOn;
  }


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


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     const  Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.0),
                        child:  Text("Notification",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Transform.scale(
                          scale: 0.65,
                          child: CupertinoSwitch(
                            activeColor: Colors.blue,
                            value: turnNotificationOn,
                            onChanged: (value) {
                              turnNotificationOn = value;
                              var pInstance =
                              Provider.of<PlayerItems>(context,
                                  listen: false);
                              turnNotificationOn
                                  ? pInstance.enableNotification()
                                  : pInstance.disableNotification();
                              pInstance.turnNotificationOn = turnNotificationOn;
                              changeNotificationSettings.setBool(
                                  'changeNotificationMode', turnNotificationOn);
                              setState(() {});
                            },
                          ),
                        ),
                      )
                    ],
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
