import 'package:flutter/material.dart';
import 'package:w9/data/repositories/artists/artist_repository.dart';
import 'package:w9/model/artists/artist.dart';
import 'package:w9/ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  Artist? selectedArtist;

  ArtistViewModel({required this.artistRepository}) {
    
    _init();
  }

  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  void _init() async {
    fetchArtists();
    
  }

  void fetchArtists() async {
    // 1- Loading state
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Artist> artists = await artistRepository.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      // 3- Fetch is unsucessfull
      artistsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void selectArtist(Artist artist) {
    selectedArtist = artist;
    notifyListeners();
  }
}
