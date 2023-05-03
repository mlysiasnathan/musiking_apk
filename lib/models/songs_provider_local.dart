import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../widgets/seekbar.dart';

class SongsLocal with ChangeNotifier {
  List<SongModel> songs = <SongModel>[];
  AudioPlayer audioPlayer = AudioPlayer();
  PaletteGenerator? paletteGenerator;

  String currentSong = 'Click to play';
  int currentIndex = 0;
  bool isPlaying = false;
  bool isLoading = false;
  bool pageLoaded = false;
  bool isViewMoreAlbum = false;
  List<AudioSource> sources = [];
  Duration songPosition = Duration.zero;
  Color defaultLightColor = Colors.orange;
  Color defaultDarkColor = Colors.deepOrange;
  void refreshSongList() {
    pageLoaded = !pageLoaded;
    notifyListeners();
  }

  ConcatenatingAudioSource initializePlaylist(List<SongModel> songsToPlay) {
    if (sources.isEmpty) {
      for (var song in songsToPlay) {
        sources.add(AudioSource.uri(Uri.parse(song.uri!)));
      }
      return ConcatenatingAudioSource(children: sources);
    }
    return ConcatenatingAudioSource(children: sources);
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

  void playPause(SongModel song) {
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
    }
    notifyListeners();
  }

  void prev() {
    if (audioPlayer.hasPrevious) {
      audioPlayer.seekToPrevious();
    }
    isPlaying = true;
    notifyListeners();
  }

  void viewMoreAlbum() {
    isViewMoreAlbum = !isViewMoreAlbum;
    notifyListeners();
  }

  void setCurrentSong(int index) async {
    if (songs.isNotEmpty) {
      currentSong = songs[index].title;
      currentIndex = index;
      isPlaying = true;
    }
    notifyListeners();
  }

  Future<PaletteGenerator?> generateColors() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset('assets/musiccovers/smoker.jpg').image,
      size: const Size.square(1000),
      region: const Rect.fromLTRB(0, 0, 1000, 1000),
    );
    notifyListeners();
    return paletteGenerator;
  }
}
