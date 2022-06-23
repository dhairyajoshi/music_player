class Track {
  String name;
  String album;
  String artist;
  int id;

  Track({required this.name, required this.album, required this.artist,required this.id});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        name: json['track_name'],
        album: json['album_name'],
        artist: json['artist_name'],
        id:json['track_id']);
        
  }
}
