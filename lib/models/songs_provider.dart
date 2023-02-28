import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import 'package:musiking/models/song_model.dart';

import '../widgets/seekbar.dart';

class Songs with ChangeNotifier {
  List<Song> _songs = <Song>[
    Song(
      title: 'High',
      descriptions: 'TheChainsmokers - So Far So Good 2023',
      musicUrl: 'assets/musics/High.mp3',
      coverUrl: 'assets/musiccovers/smoker.jpg',
    ),
    Song(
      title: 'Need To Know',
      descriptions: 'Doja Cat - Planet Her',
      musicUrl: 'assets/musics/Need To Know.mp3',
      coverUrl: 'assets/musiccovers/doja.jpg',
    ),
    Song(
      title: 'Dam Dam',
      descriptions: 'The Parakit 2018',
      musicUrl: 'assets/musics/Dam Dam.mp3',
      coverUrl: 'assets/musiccovers/nrj18.jpg',
    ),
    Song(
      title: 'Need To Know Duplicate',
      descriptions: 'Doja Cat - Planet Her',
      musicUrl: 'assets/musics/Need To Know.mp3',
      coverUrl: 'assets/musiccovers/doja.jpg',
    ),
    Song(
      title: 'Dam Dam Duplicate',
      descriptions: 'The Parakit 2018',
      musicUrl: 'assets/musics/Dam Dam.mp3',
      coverUrl: 'assets/musiccovers/nrj18.jpg',
    ),
    Song(
      title: 'High Duplicate',
      descriptions: 'TheChainsmokers - So Far So Good 2023',
      musicUrl: 'assets/musics/High.mp3',
      coverUrl: 'assets/musiccovers/smoker.jpg',
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
  PaletteGenerator? paletteGenerator;

  late Song currentSong = songs[0];
  bool isPlaying = false;
  bool isLoading = false;
  bool isViewMoreAlbum = false;
  Duration songPosition = Duration.zero;
  Color defaultLightColor = Colors.orange;
  Color defaultDarkColor = Colors.deepOrange;

  void initializePlayer(Song song) {
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          // songs
          //     .map(
          //       (son) =>

          AudioSource.uri(Uri.parse('asset:///${song.musicUrl}')),
          AudioSource.uri(Uri.parse('asset:///${songs[1].musicUrl}')),
          AudioSource.uri(Uri.parse('asset:///${songs[2].musicUrl}')),
          AudioSource.uri(Uri.parse('asset:///${songs[3].musicUrl}')),
          AudioSource.uri(Uri.parse('asset:///${songs[4].musicUrl}')),
          AudioSource.uri(Uri.parse('asset:///${songs[5].musicUrl}')),
          // )
          // .toList(),
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
    audioPlayer.position == Duration.zero ? initializePlayer(song) : null;

    if (audioPlayer.playerState.processingState == ProcessingState.loading ||
        audioPlayer.playerState.processingState == ProcessingState.buffering) {
      isLoading = true;
    } else if (!audioPlayer.playing) {
      audioPlayer.play();
    } else if (audioPlayer.playerState.processingState !=
        ProcessingState.completed) {
      audioPlayer.pause();
    } else if (audioPlayer.playerState.processingState ==
        ProcessingState.completed) {
      currentSong = songs[audioPlayer.currentIndex! + 1];
    } else {
      audioPlayer.seek(
        Duration.zero,
        index: audioPlayer.effectiveIndices!.first,
      );
    }
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void next() {
    if (audioPlayer.hasNext) {
      audioPlayer.seekToNext();
      currentSong = songs[audioPlayer.currentIndex! + 1];
    } else {
      final index = songs.indexOf(currentSong);
      if (index >= songs.length - 1) {
        return;
      } else {
        currentSong = songs[index + 1];
        initializePlayer(currentSong);
        audioPlayer.play();
      }
    }
    isPlaying = true;
    notifyListeners();
  }

  void prev() {
    if (audioPlayer.hasPrevious) {
      audioPlayer.seekToPrevious();
      currentSong = songs[audioPlayer.currentIndex! - 1];
    } else {
      final index = songs.indexOf(currentSong);
      if (index <= 0) {
        return;
      } else {
        currentSong = songs[index - 1];
        initializePlayer(currentSong);
        audioPlayer.play();
      }
    }
    isPlaying = true;
    notifyListeners();
  }

  void viewMoreAlbum() {
    isViewMoreAlbum = !isViewMoreAlbum;
    notifyListeners();
  }

  void clickToPlay(Song song) {
    currentSong = song;
    initializePlayer(currentSong);
    audioPlayer.play();
    isPlaying = true;
    // generateColors();
    notifyListeners();
  }

  Future<PaletteGenerator?> generateColors() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset(currentSong.coverUrl).image,
      size: const Size.square(1000),
      region: const Rect.fromLTRB(0, 0, 1000, 1000),
    );
    notifyListeners();
    return paletteGenerator;
  }
}
