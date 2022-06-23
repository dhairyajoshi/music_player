// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:music_player/models/trackDetailModel.dart';
import 'package:music_player/services/newtorkservices.dart';

class TrackDetailScreen extends StatelessWidget {
  int id;
  TrackDetailScreen({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Detail')),
      body: FutureBuilder(
        future: API().getDetails(id) ,
        builder: (context,AsyncSnapshot snap){
          
          if(snap.hasData){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15), 
              child: ListView(
                children: [
                  Text('Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 5,),
                  Text(snap.data.name,style: TextStyle(fontSize: 22),) , 
                  SizedBox(height: 10,),
                  Text('Album',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 5,),
                  Text(snap.data.album,style: TextStyle(fontSize: 22)), 
                  SizedBox(height: 10,),
                  Text('Artist',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)), 
                  SizedBox(height: 5,),
                  Text(snap.data.artist,style: TextStyle(fontSize: 22)), 
                  SizedBox(height: 10,),
                  Text('Explicit',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 5,),
                  Text(snap.data.explicit==0?'false':'true',style: TextStyle(fontSize: 22)), 
                  SizedBox(height: 10,),
                  Text('Rating',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 5,),
                  Text('${snap.data.rating}',style: TextStyle(fontSize: 22)), 
                  SizedBox(height: 10,),

                  Text('Lyrics',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)), 
                  SizedBox(height: 5,),
                  Text(snap.data.lyrics,style: TextStyle(fontSize: 22)), 
                 
                ],
              ),
            );
          }
          else 
            return Center(child:CircularProgressIndicator());
        },
      ),
    );
  }
}