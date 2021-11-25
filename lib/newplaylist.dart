import 'package:akshathi/home.dart';
import 'package:flutter/material.dart';

class Newplaylist extends StatefulWidget {
  const Newplaylist({Key? key}) : super(key: key);

  @override
  State<Newplaylist> createState() => _NewplaylistState();
}

class _NewplaylistState extends State<Newplaylist> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
          },
          icon: const Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
        ),
        backgroundColor: Colors.black,
        title: const Text('PLAYLIST NAME',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children:  [
             const Icon(
               Icons.queue_music_outlined,size: 80.0,color: Colors.white,
             ),
              const Text('No songs added yet.',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              const Text('You can start with your recently played songs below.',style: TextStyle(color: Colors.white),),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListTile(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                  },
                  leading: const Image(image: AssetImage('assets/images/now.png')),
                  title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                  subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                  trailing: const Icon(Icons.add_circle_outline_outlined,color: Colors.white,),
                ),
              ),
              ListTile(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.add_circle_outline_outlined,color: Colors.white,),              ),
              ListTile(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.add_circle_outline_outlined,color: Colors.white,),              ),

              ListTile(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.add_circle_outline_outlined,color: Colors.white,),              ),

              ListTile(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.add_circle_outline_outlined,color: Colors.white,),              ),

              ListTile(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.add_circle_outline_outlined,color: Colors.white,),              ),

              ListTile(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.add_circle_outline_outlined,color: Colors.white,),              ),
            ],
          ),),
      )
      ,
    );
  }

  Widget PopupDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.done_all_outlined,color: Colors.black,),
          Text("Added Successfully",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

}
