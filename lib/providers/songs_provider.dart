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
  List<SongModel> favorites = <SongModel>[];
  AudioPlayer audioPlayer = AudioPlayer();
  bool isSongsSaved = false;
  SongModel? currentSong;
  Duration position = Duration.zero;
  List<AudioSource> sources = [];
  final ScrollController scrollCtrl = ScrollController();

  Future<void> initSongData() async {
    await loadAllSongs()
        .then((_) => loadCurrentSong())
        .then((_) => loadCurrentPlayList())
        .then((_) => loadFavoritesSongs());
  }

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

  Future<void> loadAllSongs() async {
    final pref = await SharedPreferences.getInstance();
    final List<String> songListString = pref.getStringList('songList') ?? [];
    if (songListString.isNotEmpty) {
      songs = songListString
          .map((songString) => SongModel(jsonDecode(songString)))
          .toList();
    }
  }

  void saveSongList() async {
    final pref = await SharedPreferences.getInstance();
    final songListString =
        songs.map((song) => jsonEncode(song.getMap)).toList();
    pref.setStringList('songList', songListString);
  }

  void getSongsList({required List<SongModel> songsList}) {
    if (songsList.isNotEmpty) {
      songs = songsList;
    } else {
      songs.clear();
    }
    notifyListeners();
    saveSongList();
  }

  Future<void> loadFavoritesSongs() async {
    final pref = await SharedPreferences.getInstance();
    final List<String> songListString = pref.getStringList('favorites') ?? [];
    if (songListString.isNotEmpty) {
      favorites = songListString
          .map((songString) => SongModel(jsonDecode(songString)))
          .toList();
    }
  }

  void saveFavoritesSongs() async {
    final pref = await SharedPreferences.getInstance();
    final songListString =
        favorites.map((song) => jsonEncode(song.getMap)).toList();
    pref.setStringList('favorites', songListString);
    notifyListeners();
  }

  Future<void> loadCurrentPlayList() async {
    final pref = await SharedPreferences.getInstance();
    final List<String> songListString =
        pref.getStringList('currentPlaylist') ?? [];
    if (songListString.isNotEmpty) {
      currentPlaylist = songListString
          .map((songString) => SongModel(jsonDecode(songString)))
          .toList();
    }
  }

  void saveCurrentPlayList() async {
    final pref = await SharedPreferences.getInstance();
    final songListString =
        currentPlaylist.map((song) => jsonEncode(song.getMap)).toList();
    pref.setStringList('currentPlaylist', songListString);
    notifyListeners();
  }

  void refreshSongs() {
    songs.clear();
    notifyListeners();
  }

  void saveCurrentSong(SongModel song) async {
    if (currentSong != song) {
      final pref = await SharedPreferences.getInstance();
      final currentSongInfo = jsonEncode(song.getMap);
      pref.setString('currentSongInfo', currentSongInfo);
    }
    if (currentPlaylist.isNotEmpty && currentSong != song) {
      currentSong = song;
      notifyListeners();
    }
  }

  Future<void> loadCurrentSong() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('currentSongInfo')) return;
    final String? extractedSong = pref.getString('currentSongInfo');
    if (extractedSong == null) return;
    final Map<String, dynamic> songMap = jsonDecode(extractedSong);
    // print('========================ANALYSIS GET=====================');
    currentSong = SongModel(songMap);
    notifyListeners();
  }
}
