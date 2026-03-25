import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:w9/data/dtos/artist_dto.dart';
import 'package:w9/data/repositories/artists/artist_repository.dart';
import 'package:w9/model/artists/artist.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistUri = Uri.https(
    'week-8-practice-53f43-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);
    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> artistJson = json.decode(response.body);
      List<Artist> result = [];

      for (var iterable in artistJson.entries) {
        String artistId = iterable.key;
        Map<String, dynamic> values = iterable.value;
        result.add(ArtistDto.fromJson(artistId ,values));
      }
      
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }
}
