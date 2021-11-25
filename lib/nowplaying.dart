// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
//
// class Nowplaying extends StatefulWidget {
//   const Nowplaying({Key? key}) : super(key: key);
//
//   @override
//   State<Nowplaying> createState() => _NowplayingState();
// }
//
// class _NowplayingState extends State<Nowplaying>
//     with SingleTickerProviderStateMixin{
//
//   final urlImages = [
//     'assets/images/beggin.jpg'
//   ];
//
//   late AnimationController
//   iconController;
//
//   bool isAnimated = false;
//   bool click = true;
//   bool play = true;
//
//   AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     iconController = AnimationController(
//         vsync: this, duration: Duration(milliseconds: 1000));
//     audioPlayer.open(Audio('assets/audio.mp3'),autoStart: false,showNotification: true);
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text('Now Playing',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
//         centerTitle: true,
//
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 15.0),
//           child: Column(
//             children: [
//               CarouselSlider.builder(
//                 options: CarouselOptions(
//                   height: 400,
//                   enlargeCenterPage: true
//                 ),
//                 itemCount: urlImages.length,
//                 itemBuilder: (context, index, realIndex){
//                   final urlImage = urlImages[index];
//
//                   return buildImage(urlImage, index);
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 15.0),
//                 child: Container(
//                  decoration: const BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.all(Radius.circular(10))
//                  ),
//                  child: Column(
//                    children: [
//
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: [
//                          IconButton(onPressed: (){
//                            setState(() {
//                              click = !click;
//                            });
//                          }, icon: Icon((click == true)? Icons.favorite_border : Icons.favorite,),
//                          ),
//
//                          IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz)),
//
//                        ],
//                      ),
//
//                      Padding(
//                        padding: const EdgeInsets.fromLTRB(8.0,20.0,8.0,5.0),
//                        child: ProgressBar(
//                          thumbRadius: 7.0,
//                          baseBarColor: Colors.black,
//                          progressBarColor: Colors.black,
//                          thumbColor: Colors.black,
//                          progress: const Duration(minutes:2),
//                          total: const Duration(minutes: 5),
//                          onSeek: (duration) {
//                            print('User selected a new time: $duration');
//                          },
//                        ),
//                      ),
//
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: [
//                          IconButton(onPressed: (){}, icon: const Icon(Icons.shuffle)),
//                          IconButton(onPressed: (){}, icon: const Icon(Icons.skip_previous),iconSize: 40.0,),
//
//                          GestureDetector(
//                            onTap: () {
//                              AnimateIcon();
//                            },
//                            child: AnimatedIcon(
//                              icon: AnimatedIcons.play_pause,
//                              progress: iconController,
//                              size: 50,
//                              color: Colors.black,
//                            ),
//                          ),
//
//                          // IconButton(onPressed: (){
//                          //   setState(() {
//                          //     audioPlayer.play();
//                          //
//                          //     play = !play;
//                          //   });
//                          // }, icon: Icon((play == true)? Icons.play_circle_outlined : Icons.pause_circle_outlined,),iconSize: 80.0,
//                          // ),
//                          // IconButton(onPressed: (){}, icon: const Icon(Icons.pause_circle_outlined),iconSize: 80.0,),
//                          IconButton(onPressed: (){}, icon: const Icon(Icons.skip_next),iconSize: 40.0,),
//                          IconButton(onPressed: (){}, icon: const Icon(Icons.repeat)),
//                        ],
//                      ),
//                    ],
//                  ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget buildImage(String urlImage, int index) => Container(
//     color: Colors.grey,
//     child: Image.asset(
//       urlImage,
//       fit: BoxFit.cover,
//     ),
//   );
//
//
//   void AnimateIcon() {
//     setState(() {
//       isAnimated = !isAnimated;
//
//       if(isAnimated)
//       {
//         audioPlayer.play();
//         iconController.forward();
//       }else{
//         audioPlayer.pause();
//         iconController.reverse();
//       }
//
//
//     });
//   }
//
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     iconController.dispose();
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
// }
//
//
