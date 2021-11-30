// import 'dart:html';
import 'package:flutter/material.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';

class PlayerItems extends ChangeNotifier{

  List<String> songsPathList = [];

  List<String> sampleKeys =[];

  getAllSongsPaths(List<String> songPathList){
    songPathList.forEach((element) {
      final audio = Audio.file(element);
      allSongsplayList.add(audio);
    });
  }

  showKeys(){
    selectModeOfPlaylist().forEach((element) {debugPrint(element.path);});
  }



  // Managing Carousal Here

  List<int?> carousalImagepaths = [];

  int? selectedSongKey;
  bool isIconChanged = false;
  String? currentSongDuration;
  bool isSelectedOrNot = true;
  int? currentSongKey = 0;





  final _assetsAudioPlayer = AssetsAudioPlayer();
  List<Audio> allSongsplayList = <Audio>[];

  int modeOfPlaylist = 1;
  selectModeOfPlaylist() {
    if (modeOfPlaylist == 1) {
      return allSongsplayList;
    }
  }

  opnPlaylist(startingIndex) async{
    listenEverything();
    change();
    try{
      await _assetsAudioPlayer.open(
          Playlist(audios: selectModeOfPlaylist(),startIndex: startingIndex!),autoStart: true,loopMode: LoopMode.playlist,showNotification: true,
          notificationSettings: NotificationSettings(
            customPlayPauseAction: (handle){
              playOrpause();
            },
            customNextAction: (handle){
              next();
            },
            customPrevAction: (handle){
              prev();
            },
            customStopAction: (handle){
              _assetsAudioPlayer.stop();
            },

          )
      );
      notifyListeners();
    }catch(e){
      debugPrint("Can't Play Songs");
      notifyListeners();
    }
    notifyListeners();
  }

  listenEverything(){
    _assetsAudioPlayer.current.listen((event) {
      selectedSongKey = _assetsAudioPlayer.current.value!.index;
    });
  }

  next(){
    _assetsAudioPlayer.next();
  }
  prev(){
    _assetsAudioPlayer.previous();
  }

  change(){
    _assetsAudioPlayer.isPlaying.listen((event) {
      debugPrint("\n------------------Playing Or Not ${_assetsAudioPlayer.isPlaying.value.toString()}\n-----------------------");
      if(_assetsAudioPlayer.isPlaying.value == true){
        isIconChanged = true;
        notifyListeners();
      }else{
        isIconChanged = false;
        notifyListeners();
      }
      notifyListeners();
    });
  }
  playOrpause(){
    _assetsAudioPlayer.playOrPause();
  }

//  Slider

  var currentPosition ;
  Duration? dur = const Duration(seconds: 0);
  double? curr = 0;

  totalDuration() {
    _assetsAudioPlayer.current.listen((event) {
      dur = event!.audio.duration;

    });
    return
      Text(dur.toString().split('.')[0]);
  }


  getDuration() {
    return StreamBuilder(
        stream: _assetsAudioPlayer.currentPosition,
        builder: (context, asyncSnapshot) {
          currentPosition = asyncSnapshot.data;
          return Text(currentPosition.toString().split('.')[0]);
        });
  }
  current() {
    curr = currentPosition!.inSeconds.toDouble();
    notifyListeners();
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.yellow,
      inactiveColor: Colors.grey,
      value: curr!.toDouble(),
      min: 0.0,
      max: dur!.inSeconds.toDouble(),
      onChanged: (double newValue) {
        changeToSeconds(curr!.toInt());
        curr = newValue;
        notifyListeners();
      },
    );
  }
  void changeToSeconds(int seconds) {
    Duration newDuration = Duration(seconds: seconds);
    _assetsAudioPlayer.seek(newDuration);
    notifyListeners();
  }

}