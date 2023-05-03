import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/playlists_provider.dart';
import '../models/songs_provider.dart';
import '../widgets/album_music.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/discover_music.dart';
import '../widgets/playlist_local_music.dart';
import '../widgets/playlist_music.dart';
import '../widgets/pre_playing_floating_action_bar_local.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    final OnAudioQuery _audioQuery = OnAudioQuery();
    final songsData = Provider.of<Songs>(context, listen: false);
    final songs = songsData.songs;
    final playlists = Provider.of<Playlists>(context, listen: false).playlists;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red.withOpacity(0.8),
            Colors.orange.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(),
        bottomNavigationBar: const CustomBottomBar(indexPage: 0),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const DiscoverMusic(),
              AlbumMusic(playlists: playlists),
              LocalPlaylistMusic(audioQuery: _audioQuery),
              PlaylistMusic(songs: songs),
              const SizedBox(height: 32),
            ],
          ),
        ),
        floatingActionButton: const PrePlayingSong(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
