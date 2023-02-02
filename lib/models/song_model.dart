import 'package:flutter/material.dart';

class Song with ChangeNotifier {
  final String title;
  final String descriptions;
  final String musicUrl;
  final String coverUrl;
  // final ImageProvider coverProv;

  bool isFavorite;

  Song({
    required this.title,
    required this.descriptions,
    required this.musicUrl,
    required this.coverUrl,
    // required this.coverProv,
    this.isFavorite = false,
  });
  void toggleFavoritesStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
