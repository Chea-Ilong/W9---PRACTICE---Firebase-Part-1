class Song {
  final String title;
  final Duration duration;
  final String artistId;
  final Uri imageUrl;

  Song({
    required this.title,
    required this.duration,
    required this.artistId,
    required this.imageUrl,
});

  @override
  String toString() {
    return 'Song(title: $title, duration: $duration, , artist: $artistId )';
  }
}
