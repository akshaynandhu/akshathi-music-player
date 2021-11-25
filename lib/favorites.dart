import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

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

               Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListTile(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                  },
                  leading: const Image(image: AssetImage('assets/images/now.png')),
                  title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                  subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                  trailing: const Icon(Icons.delete_sweep,color: Colors.white,),
                ),
              ),
               ListTile(
                 onTap: (){
                   showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                 },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
               ListTile(
                 onTap: (){
                   showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                 },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
               ListTile(
                 onTap: (){
                   showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                 },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
               ListTile(
                 onTap: (){
                   showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                 },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
               ListTile(
                 onTap: (){
                   showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                 },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
               ListTile(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context) => PopupDialog(context));
                },
                leading: const Image(image: AssetImage('assets/images/now.png')),
                title: const Text('Blinding Lights',style: TextStyle(color: Colors.white),),
                subtitle: const Text('The Weekend',style: TextStyle(color: Colors.white),),
                trailing: const Icon(Icons.delete_sweep,color: Colors.white,),              ),
            ],
          ),),
      )
      ,
    );
  }

  Widget get image {
    return const ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60),
          bottomLeft: Radius.circular(60),
        ),
        child: Image(
          image: AssetImage('assets/images/love.jpg'),
        ),
    );
  }

  Widget PopupDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.delete_sweep,color: Colors.black,),
          Text("Removed",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

}
