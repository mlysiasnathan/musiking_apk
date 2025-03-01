import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/song/seekbar.dart';

class Songs with ChangeNotifier {
  List<SongModel> songs = <SongModel>[];
  List<SongModel> currentPlaylist = <SongModel>[];
  AudioPlayer audioPlayer = AudioPlayer();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool isSongsSaved = false;

  SongModel? currentSong;
  // int currentIndex = 0;

  Duration position = Duration.zero;
  List<AudioSource> sources = [];

  final ScrollController scrollCtrl = ScrollController();
  void autoScroll() {
    scrollCtrl.animateTo(
      scrollCtrl.position.maxScrollExtent,
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticInOut,
    );
  }

  ConcatenatingAudioSource initializePlaylist(List<SongModel> songsToPlay) {
    sources.clear();
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

  void next() {
    if (audioPlayer.hasNext) {
      audioPlayer.seekToNext();
    }
  }

  void prev() {
    if (audioPlayer.hasPrevious) {
      audioPlayer.seekToPrevious();
    }
  }

  void setCurrentSong(int songId) async {
    if (currentPlaylist.isNotEmpty) {
      currentSong = songs.firstWhere((song) => song.id == songId);
    }
    // print('Current song======================================$currentSong');
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    final currentSongInfo = json.encode({
      'currentSong': currentSong.toString(),
      'position': audioPlayer.position.toString(),
    });
    pref.setString('currentSongInfo', currentSongInfo);
  }

  Future<void> setSongs() async {
    final pref = await SharedPreferences.getInstance();
    final songListString = pref.getStringList('songList') ?? [];

    for (final songStringData in songListString) {
      print('$songStringData \n');
      // songs.add(jsonDecode(songStringData));
    }
    print(' songs data==============$songs ');
  }

  void saveSongList() async {
    final pref = await SharedPreferences.getInstance();
    final List<String> songListString = [];
    for (var song in songs) {
      songListString.add(song.toString());
    }
    pref.setStringList('songList', songListString);
  }

  void getSongsList({required List<SongModel> songsList}) {
    if (songsList.isNotEmpty) {
      songs = songsList;
      currentPlaylist = songs;
    } else {
      songs.clear();
    }
    notifyListeners();
    saveSongList();
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
      currentSong = null;
      return false;
    }
    if (extractedSongInfo['currentIndex'] == null) {
      // currentIndex = 0;
      return false;
    }
    if (extractedSongInfo['position'] == null) {
      return false;
    }
    currentSong = extractedSongInfo['currentSong'];
    // currentIndex = extractedSongInfo['currentIndex'];

    List<String> timeParts =
        extractedSongInfo['position'].toString().split(':');
    position = Duration(
      hours: int.parse(timeParts[0]),
      minutes: int.parse(timeParts[1]),
      seconds: double.parse(timeParts[2]).toInt(),
    );
    // notifyListeners();
    return true;
  }
}
