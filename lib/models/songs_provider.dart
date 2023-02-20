import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import 'package:musiking/models/song_model.dart';

import '../widgets/seekbar.dart';

class Songs with ChangeNotifier {
  List<Song> _songs = [
    Song(
      title: 'Holyday - Lil Nas X',
      descriptions: 'old song',
      musicUrl: 'assets/musics/Lil Nas X - HOLIDAY.mp3',
      coverUrl: 'assets/musiccovers/Longtemps.jpg',
    ),
    Song(
      title: 'Love Again',
      descriptions: 'Hits song',
      musicUrl: 'assets/musics/Love Again (Extended Version).mp3',
      coverUrl: 'assets/musiccovers/love.jpg',
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
      title: 'Lonely - Akon',
      descriptions: 'old song',
      musicUrl: 'assets/musics/Lonely - Akon.mp3',
      coverUrl: 'assets/musiccovers/lonely.JPG',
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

  Song findByTitle(String title) {
    return _songs.firstWhere((song) => song.title == title);
  }

  void fetchAndSetSongs() {
    final List<Song> refreshedSongs = [];
    _songs = refreshedSongs;
    notifyListeners();
  }

//============================================SONG HANDLING===============================================
  AudioPlayer audioPlayer = AudioPlayer();

  late Song currentSong = songs[0];
  bool isPlaying = false;
  bool isLoading = false;
  Duration songPosition = Duration.zero;

  void _initializePlayer(Song song) {
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${song.musicUrl}'),
          ),
        ],
      ),
    );
  }

  Stream<SeekBarData> get seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream,
        audioPlayer.durationStream,
        (
          Duration position,
          Duration? duration,
        ) {
          return SeekBarData(
            audioPlayer.position,
            audioPlayer.duration ?? Duration.zero,
          );
        },
      );

  void playPause(Song song) {
    audioPlayer.position == Duration.zero ? _initializePlayer(song) : null;

    if (audioPlayer.playerState.processingState == ProcessingState.loading ||
        audioPlayer.playerState.processingState == ProcessingState.buffering) {
      isLoading = true;
    } else if (!audioPlayer.playing) {
      audioPlayer.play();
    } else if (audioPlayer.playerState.processingState !=
        ProcessingState.completed) {
      audioPlayer.pause();
    } else {
      audioPlayer.seek(
        Duration.zero,
        index: audioPlayer.effectiveIndices!.first,
      );
    }
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void clickToPlay(Song song) {
    currentSong = song;
    _initializePlayer(currentSong);
    audioPlayer.play();
    isPlaying = true;
    notifyListeners();
  }
}
