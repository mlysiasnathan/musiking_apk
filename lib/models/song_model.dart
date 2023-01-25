class Song {
  final String title;
  final String descriptions;
  final String musicUrl;
  final String coverUrl;

  Song({
    required this.title,
    required this.descriptions,
    required this.musicUrl,
    required this.coverUrl,
  });

  static List<Song> songs = [
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
    ),
  ];
}
