// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:music_player/models/trackDetailModel.dart';
import 'package:music_player/services/newtorkservices.dart';

// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/TrackBloc.dart';
import 'package:music_player/services/connectivityservice.dart';
import 'package:music_player/services/newtorkservices.dart';
import 'package:music_player/screens/trackdetail.dart';
import '../models/trackModel.dart';

class TrackDetailScreen extends StatelessWidget {
  int id;
  TrackDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TrackDetailsBloc(API(), ConnectivityService())..add(FetchDetail(id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Track Details'),
        ),
        body: BlocBuilder<TrackDetailsBloc, TrackState>(
          builder: (context, state) {
            if (state is TrackDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TrackDetailLoaded) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: ListView(
                  children: [
                    Text(
                      'Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      state.detail.name,
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Album',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(state.detail.album, style: TextStyle(fontSize: 22)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Artist',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(state.detail.artist, style: TextStyle(fontSize: 22)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Explicit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(state.detail.explicit == 0 ? 'false' : 'true',
                        style: TextStyle(fontSize: 22)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Rating',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('${state.detail.rating}',
                        style: TextStyle(fontSize: 22)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Lyrics',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(state.detail.lyrics, style: TextStyle(fontSize: 22)),
                  ],
                ),
              );
            }
            if (state is DetailsNoInternetState) {
              return Center(
                child: Text('No internet connection!'),
              );
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
