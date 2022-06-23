import 'package:http/http.dart' as http;
import 'package:music_player/models/trackDetailModel.dart';
import 'dart:convert';
import 'package:music_player/models/trackModel.dart';

class API {
  Future<List<Track>> getTracks() async {
    List<Track> track_list = <Track>[];
    var url =
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=85b20ba27f5c1ae9e5b7c93b08402e4f';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final tracks =
          json.decode(response.body)['message']['body']['track_list'];

      for (int i = 0; i < tracks.length; i++) {
        track_list.add(Track.fromJson(tracks[i]['track']));
      }
    }

    return track_list;
  }

  Future<TrackDetail> getDetails(int id) async {
    String detUrl =
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=${id}&apikey=85b20ba27f5c1ae9e5b7c93b08402e4f';
    String lyrUrl =
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${id}&apikey=85b20ba27f5c1ae9e5b7c93b08402e4f';
    final detResponse = await http.get(Uri.parse(detUrl));
    final lyrResponse = await http.get(Uri.parse(lyrUrl));

    if (detResponse.statusCode == 200 && lyrResponse.statusCode == 200) {
      final detJson = json.decode(detResponse.body)['message'];
      final lyrJson = json.decode(lyrResponse.body)['message'];

      return TrackDetail(
          name: detJson['body']['track']['track_name'],
          album: detJson['body']['track']['album_name'],
          artist: detJson['body']['track']['artist_name'],
          lyrics: lyrJson['body']['lyrics']['lyrics_body'],
          rating: detJson['body']['track']['track_rating'],
          explicit: detJson['body']['track']['explicit']);
    }

    return TrackDetail(
        name: 'name',
        album: 'album',
        artist: 'artist',
        lyrics: 'lyrics',
        rating: 5,
        explicit: 0);
  }
}
