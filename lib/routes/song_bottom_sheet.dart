import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider.dart';
import '../widgets/background_filter_song_screen.dart';
import '../widgets/music_timer.dart';

class SongBottomSheet extends StatelessWidget {
  const SongBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        Provider.of<Songs>(context).currentSong.coverUrl,
        fit: BoxFit.cover,
      ),
      const BackgroundFilter(),
      const MusicTimer(),
    ]);
    // );
  }
}
