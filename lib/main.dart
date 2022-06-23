import 'package:flutter/material.dart';
import 'package:music_player/services/connectivityservice.dart';
import 'package:music_player/services/newtorkservices.dart';
import 'package:music_player/screens/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TrackBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => API()),
          RepositoryProvider(create: (context)=> ConnectivityService())
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
