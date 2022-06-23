class TrackDetail {
  String name;
  String artist;
  String album;
  int explicit;
  int rating;
  String lyrics;

  TrackDetail(
      {required this.name,
      required this.album,
      required this.artist,
      required this.explicit,
      required this.lyrics,
      required this.rating});
}
