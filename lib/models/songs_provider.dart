import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:musiking/models/song_model.dart';

class Songs with ChangeNotifier {
  List<Song> _songs = [
    Song(
      title: 'Lonely - Akon',
      descriptions: 'old song',
      musicUrl: 'assets/musics/Lonely - Akon.mp3',
      coverUrl: 'assets/musiccovers/lonely.JPG',
    ),
    Song(
      title: 'Love Again',
      descriptions: 'Hits song',
      musicUrl: 'assets/musics/Love Again (Extended Version).mp3',
      coverUrl: 'assets/musiccovers/love.jpg',
    ),
    Song(
      title: 'Holyday - Lil Nas X',
      descriptions: 'old song',
      musicUrl: 'assets/musics/Lil Nas X - HOLIDAY.mp3',
      coverUrl: 'assets/musiccovers/Longtemps.jpg',
    ),
    Song(
      title: 'Lonely - Akon',
      descriptions: 'old song',
      musicUrl: 'assets/musics/Lonely - Akon.mp3',
      coverUrl: 'assets/musiccovers/lonely.JPG',
    ),
    Song(
      title: 'Love Again',
      descriptions: 'Hits song',
      musicUrl: 'assets/musics/Love Again (Extended Version).mp3',
      coverUrl: 'assets/musiccovers/love.jpg',
    ),
    Song(
      title: 'Holyday - Lil Nas X',
      descriptions: 'old song',
      musicUrl: 'assets/musics/Lil Nas X - HOLIDAY.mp3',
      coverUrl: 'assets/musiccovers/Longtemps.jpg',
      // coverProv: 'assets/musiccovers/Longtemps.jpg',
    ),
  ];
  List<Song> get songs {
    return [..._songs];
  }

  List<Song> get favoritesSongs {
    return _songs.where((songItem) => songItem.isFavorite).toList();
  }

  Song findById(String title) {
    return _songs.firstWhere((song) => song.title == title);
  }

  void fetchAndSetSongs() {
    final List<Song> refreshedSongs = [];
    _songs = refreshedSongs;
    notifyListeners();
  }

  var playState = false;
}
