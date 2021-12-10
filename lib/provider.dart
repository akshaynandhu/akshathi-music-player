// import 'dart:html';
import 'dart:async';

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

  getFavSongsPaths(List<String> songPathList){
    songPathList.forEach((element) {
      final audio = Audio.file(element);
      favPlaylist.add(audio);
    });
  }
  bool didUserClickedANewPlaylst = false;

  getPlaylistSongsPaths(List<String> songPathList){
    songPathList.forEach((element) {
      final audio = Audio.file(element);
      playlistSongsPlaylist.add(audio);
    });
  }

  showKeys(){
    selectModeOfPlaylist().forEach((element) {debugPrint(element.path);});
  }

  bool  turnNotificationOn = false;

  disableNotification(){
    _assetsAudioPlayer.showNotification = false;
  }
  enableNotification(){
    _assetsAudioPlayer.showNotification = true;
  }

  var searchSongName;
  onSearchChanged(TextEditingController searchQuery){
    Timer? _debounce;
    if(_debounce?.isActive??false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500),()
    {
      searchSongName = searchQuery.text;
      notifyListeners();
    });
  }


  // Managing Carousal Here

  List<int?> carousalImagepaths = [];

  int? selectedSongKey;
  bool isIconChanged = false;
  String? currentSongDuration;
  bool isSelectedOrNot = true;
  int? currentSongKey = 0;
  int alreadyPlayingPlaylistIndex = 0;
  int test =0;
  bool isAudioPlayingFromPlaylist = false;
  bool isFavsAlreadyClicked = false;








  final _assetsAudioPlayer = AssetsAudioPlayer();
  List<Audio> allSongsplayList = <Audio>[];
  List<Audio> favPlaylist = <Audio>[];
  List<Audio> playlistSongsPlaylist = <Audio>[];

  int modeOfPlaylist = 1;

  selectModeOfPlaylist() {
    if (modeOfPlaylist == 1) {
      return allSongsplayList;
    }else if(modeOfPlaylist == 2){
      return favPlaylist;
    }else if(modeOfPlaylist == 3){
      return playlistSongsPlaylist;
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


  int? loopIcon=0;
  loopSongs(){
    _assetsAudioPlayer.toggleLoop();
    if(_assetsAudioPlayer.currentLoopMode!.index == 1){
      loopIcon = 1;
    }else if(_assetsAudioPlayer.currentLoopMode!.index == 2){
      loopIcon = 2;
    }else{
      loopIcon = 3;
    }
    notifyListeners();
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
    return StreamBuilder(
      stream: _assetsAudioPlayer.currentPosition,
      builder: (context,asyncSnapshot)=> Slider(
        activeColor: Colors.yellow,
        inactiveColor: Colors.grey,
        value: currentPosition.inSeconds.toDouble(),
        min: 0.0,
        max: dur!.inSeconds.toDouble(),
        onChanged: (double newValue) {
          changeToSeconds(curr!.toInt());
          curr = newValue;
          notifyListeners();
        },
      ),
    );
  }
  void changeToSeconds(int seconds) {
    Duration newDuration = Duration(seconds: seconds);
    _assetsAudioPlayer.seek(newDuration);
    notifyListeners();
  }

}