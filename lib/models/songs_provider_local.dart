import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/seekbar.dart';

class SongsLocal with ChangeNotifier {
  List<SongModel> songs = <SongModel>[];
  List<SongModel> currentPlaylist = <SongModel>[];
  AudioPlayer audioPlayer = AudioPlayer();
  PaletteGenerator? paletteGenerator;

  String currentSong = 'Click to play';
  int currentIndex = 0;
  bool isPlaying = false;
  bool isLoading = false;
  bool pageLoaded = false;
  Duration position = Duration.zero;
  List<AudioSource> sources = [];
  Color defaultLightColor = Colors.orange;
  Color defaultDarkColor = Colors.red;
  void refreshSongList() {
    pageLoaded = !pageLoaded;
    notifyListeners();
  }

  ConcatenatingAudioSource initializePlaylist(List<SongModel> songsToPlay) {
    // sources.isNotEmpty && sources.length != songsToPlay.length
    //     ?
    sources.clear();
    // : null;
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

  void setCurrentSong(int index) async {
    if (currentPlaylist.isNotEmpty) {
      currentSong = currentPlaylist[index].title;
      currentIndex = index;
      isPlaying = true;
    }
    final pref = await SharedPreferences.getInstance();
    final currentSongInfo = json.encode({
      'currentSong': currentSong,
      'currentIndex': currentIndex,
      'position': audioPlayer.position.toString(),
    });
    pref.setString('currentSongInfo', currentSongInfo);
    notifyListeners();
  }

  Future<bool> fetchAndSetCurrentSong() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('currentSongInfo')) {
      return false;
    }
    final extractedSongInfo =
        json.decode(pref.getString('currentSongInfo').toString())
            as Map<String, dynamic>;
    if (extractedSongInfo['currentSong'] == null) {
      currentSong = 'Click to play';
      return false;
    }
    if (extractedSongInfo['currentIndex'] == null) {
      currentIndex = 0;
      return false;
    }
    if (extractedSongInfo['position'] == null) {
      return false;
    }
    currentSong = extractedSongInfo['currentSong'];
    currentIndex = extractedSongInfo['currentIndex'];

    List<String> timeParts =
        extractedSongInfo['position'].toString().split(':');
    position = Duration(
      hours: int.parse(timeParts[0]),
      minutes: int.parse(timeParts[1]),
      seconds: double.parse(timeParts[2]).toInt(),
    );
    notifyListeners();
    return true;
  }

  ImageProvider getImage() {
    Image image = Image.asset('assets/musiccovers/musiking_logo.jpg');
    FutureBuilder<Uint8List?>(
        future: OnAudioQuery().queryArtwork(
          currentPlaylist[currentIndex].id,
          ArtworkType.AUDIO,
        ),
        builder: (context, item) {
          print('try generate color inside==============================');
          if (item.data != null && item.data!.isNotEmpty) {
            return image = Image.memory(
              item.data!,
              gaplessPlayback: false,
              repeat: ImageRepeat.noRepeat,
              scale: 1.0,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
              errorBuilder: (context, exception, stackTrace) {
                return image;
              },
            );
          }
          return image;
        });
    print('Image ====================================== $image');
    return image.image;
  }

  Future<PaletteGenerator?> generateColors() async {
    print('=================color generated');
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      // Image.asset('assets/musiccovers/musiking_logo.jpg').image,
      getImage(),
      size: const Size.square(1000),
      region: const Rect.fromLTRB(0, 0, 1000, 1000),
    );
    notifyListeners();
    return paletteGenerator;
  }
}
