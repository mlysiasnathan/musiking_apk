import 'package:flutter/material.dart';

import '../models/playlist_model.dart';
import '../models/songs_provider.dart';

class Playlists with ChangeNotifier {
  List<Playlist> playlists = [
    Playlist(
      title: 'Hip-Hop R&B',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/lonely.JPG',
    ),
    Playlist(
      title: 'Rock & Roll',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/love.jpg',
    ),
    Playlist(
      title: 'Techno',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/Longtemps.jpg',
    ),
    Playlist(
      title: 'Slow',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/love.jpg',
    ),
  ];
}
