import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Playlists with ChangeNotifier {
  List<AlbumModel> playlists = [];
  bool isViewMoreAlbum = false;

  void viewMoreAlbum() {
    isViewMoreAlbum = !isViewMoreAlbum;
    notifyListeners();
  }

  void getAlbumsList({required List<AlbumModel> albumsList}) {
    if (albumsList.isNotEmpty) {
      playlists = albumsList;
    } else {
      playlists.clear();
    }
    notifyListeners();
    saveAlbumList();
  }

  void saveAlbumList() async {
    final pref = await SharedPreferences.getInstance();
    final albumListString =
        playlists.map((playlist) => jsonEncode(playlist.getMap)).toList();
    pref.setStringList('albums', albumListString);
  }

  Future<void> loadPlaylists() async {
    final pref = await SharedPreferences.getInstance();
    final List<String> albumListString = pref.getStringList('albums') ?? [];
    if (albumListString.isNotEmpty) {
      playlists = albumListString
          .map((songString) => AlbumModel(jsonDecode(songString)))
          .toList();
    }
  }

  void refreshPlaylists() {
    playlists.clear();
    notifyListeners();
  }

// Future<List<AlbumModel>> setAlbumsList() async {
//   await _audioQuery
//       .queryAlbums(
//           sortType: null,
//           ignoreCase: true,
//           uriType: UriType.EXTERNAL,
//           orderType: OrderType.ASC_OR_SMALLER)
//       .then((albumsList) {
//     if (albumsList.isNotEmpty) {
//       playlists.clear();
//       playlists = albumsList;
//       notifyListeners();
//     } else {
//       playlists.clear();
//     }
//   });
//   return playlists;
// }
}
