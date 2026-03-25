import 'package:w9/model/artists/artist.dart';

class ArtistDto {
  static const String nameKey = 'name';
  static const String genreKey = 'genre';
  static const String imageURLKey = 'imageUrl';

  static Artist fromJson(Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[genreKey] is String);
    assert(json[imageURLKey] is String);

    return Artist(
      name: json[nameKey],
      genre: json[genreKey],
      imageUrl: Uri.parse(json[imageURLKey]),
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Artist artist) {
    return {
      nameKey: artist.name,
      genreKey: artist.genre,
      imageURLKey: artist.imageUrl,
    };
  }
}
