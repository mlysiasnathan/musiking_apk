import 'package:flutter/material.dart';

import '../models/playlist_model.dart';
import '../models/songs_provider.dart';

class Playlists with ChangeNotifier {
  List<Playlist> playlists = [
    Playlist(
      title: 'NRJ 2018',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/smoker.jpg',
    ),
    Playlist(
      title: 'So Far So Good 2023',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/smoker.jpg',
    ),
    Playlist(
      title: 'Planet Her',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/smoker.jpg',
    ),
    Playlist(
      title: 'NRJ 2018',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/smoker.jpg',
    ),
    Playlist(
      title: 'So Far So Good 2023',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/smoker.jpg',
    ),
    Playlist(
      title: 'Planet Her',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/smoker.jpg',
    ),
    Playlist(
      title: 'Other Songs',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/smoker.jpg',
    ),
    Playlist(
      title: 'Planet Her',
      songs: Songs().songs,
      imgUrl: 'assets/musiccovers/smoker.jpg',
    ),
  ];
}
