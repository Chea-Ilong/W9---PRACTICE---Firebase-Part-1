import 'package:w9/model/artists/artist.dart';

abstract class ArtistRepository {
    Future<List<Artist>> fetchArtists();
}