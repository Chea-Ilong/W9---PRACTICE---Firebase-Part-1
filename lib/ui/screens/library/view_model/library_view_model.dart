import 'package:flutter/material.dart';
import 'package:w9/data/repositories/artists/artist_repository.dart';
import 'package:w9/model/artists/artist.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  final ArtistRepository artistRepository;

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();
  Map<String, Artist> artistsById = {};

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();
      List<Artist> artists = await artistRepository.fetchArtists();
      // loop through the list and store as map for the key-pair lookup
      //artist id to artist object value 
      artistsById = {for (final artist in artists) artist.id: artist};

      songsValue = AsyncValue.success(songs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
  // use this to get the associate artist for that song 
  // as song already have the artist id in it 
  Artist getArtistForSong(Song song) {
    return artistsById[song.artistId]!;
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
