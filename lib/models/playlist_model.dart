import 'package:flutter/material.dart';
import 'package:musiking/models/song_model.dart';

class Playlist with ChangeNotifier {
  final String title;
  final List<Song> songs;
  final String imgUrl;

  Playlist({
    required this.title,
    required this.songs,
    required this.imgUrl,
  });
}
