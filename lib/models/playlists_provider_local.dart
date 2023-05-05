import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlists with ChangeNotifier {
  List<AlbumModel> playlists = [];
  bool isViewMoreAlbum = false;
  void viewMoreAlbum() {
    isViewMoreAlbum = !isViewMoreAlbum;
    notifyListeners();
  }
}
