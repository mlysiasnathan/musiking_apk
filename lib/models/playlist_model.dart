import 'package:musiking/models/song_model.dart';

class Playlist {
  final String title;
  final List<Song> songs;
  final String imgUrl;

  Playlist({
    required this.title,
    required this.songs,
    required this.imgUrl,
  });
  static List<Playlist> playlists = [
    Playlist(
      title: 'Hip-Hop R&B',
      songs: Song.songs,
      imgUrl: 'assets/musiccovers/lonely.JPG',
    ),
    Playlist(
      title: 'Rock & Roll',
      songs: Song.songs,
      imgUrl: 'assets/musiccovers/love.jpg',
    ),
    Playlist(
      title: 'Techno',
      songs: Song.songs,
      imgUrl: 'assets/musiccovers/Longtemps.jpg',
    ),
    Playlist(
      title: 'Slow',
      songs: Song.songs,
      imgUrl: 'assets/musiccovers/love.jpg',
    ),
  ];
}
