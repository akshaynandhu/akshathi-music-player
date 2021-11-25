import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: IntroductionScreen(
      pages: [
        PageViewModel(

          image: buildImage('assets/images/image3.jpg'),
        )
      ],

      done: const Text('GET START',style: TextStyle(fontWeight: FontWeight.bold),),
      onDone: () {},
    ),
    );
  }
  Widget buildImage(String path)=>
      Center(child: Image.asset(path,width: 350,),);
}
