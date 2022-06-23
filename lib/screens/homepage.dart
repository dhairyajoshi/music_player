// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/TrackBloc.dart';
import 'package:music_player/services/connectivityservice.dart';
import 'package:music_player/services/newtorkservices.dart';
import 'package:music_player/screens/trackdetail.dart';
import '../models/trackModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackBloc(
        RepositoryProvider.of<API>(context),
        RepositoryProvider.of<ConnectivityService>(context)
      )..add(FetchList()),
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Trending')),
        ),
        body: BlocBuilder<TrackBloc, TrackState>(
          builder: (context, state) {
            
            if (state is TrackListLoading) {

              return Center(child: CircularProgressIndicator());

            } else if (state is TrackListLoaded) {

              return ListView.builder(
                itemCount: state.tracks.length,
                itemBuilder: (context, index) {
                  return TrackTile(track: state.tracks[index]);
                },
                
              );
            }
            if(state is NoInternetState)
            {
              
              return Center(child: Text('No internet connection!'),); 
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class TrackTile extends StatelessWidget {
  Track track;
  TrackTile({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackDetailScreen(id: track.id),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                flex: 2, child: Center(child: Icon(Icons.music_note_rounded))),
            Flexible(
              flex: 8,
              child: Column(
                children: [
                  Text(
                    track.name.length > 21
                        ? '${track.name.substring(0, 22)}...'
                        : track.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    track.album.length > 21
                        ? '${track.album.substring(0, 22)}...'
                        : track.album,
                  )
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  track.artist,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
