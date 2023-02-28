import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider.dart';
import '../widgets/background_filter_song_screen.dart';
import '../widgets/music_timer.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});
  static const routeName = '/song';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          Provider.of<Songs>(context).currentSong.coverUrl,
          fit: BoxFit.cover,
        ),
        const BackgroundFilter(),
        const MusicTimer(),
      ]),
    );
  }
}
