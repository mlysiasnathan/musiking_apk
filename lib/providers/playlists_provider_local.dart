import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlists with ChangeNotifier {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<AlbumModel> playlists = [];
  bool isViewMoreAlbum = false;
  void viewMoreAlbum() {
    isViewMoreAlbum = !isViewMoreAlbum;
    notifyListeners();
  }

  Future<void> setAlbumsList() async {
    _audioQuery
        .queryAlbums(
            sortType: null,
            ignoreCase: true,
            uriType: UriType.EXTERNAL,
            orderType: OrderType.ASC_OR_SMALLER)
        .then((albumsList) {
      if (albumsList.isNotEmpty) {
        playlists.clear();
        playlists = albumsList;
        notifyListeners();
      } else {
        playlists.clear();
      }
    });
  }
}
