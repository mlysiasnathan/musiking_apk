import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class SongPlayerScreen extends StatelessWidget {
  const SongPlayerScreen({super.key});
  static const routeName = '/songScreen-local';
  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context, listen: false);
    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null ? songData.setCurrentSong(index) : null;
      songData.generateColors();
    });
    return Scaffold(
      body: Stack(children: [
        Consumer<SongsLocal>(
          builder: (ctx, songData, child) => QueryArtworkWidget(
            id: songData.songs[songData.currentIndex].id,
            type: ArtworkType.AUDIO,
            artworkFit: BoxFit.cover,
            artworkHeight: double.infinity,
            artworkWidth: double.infinity,
            artworkBorder: BorderRadius.zero,
            nullArtworkWidget: ClipRRect(
              child: Image.asset(
                'assets/musiccovers/musiking_logo.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
        const BackgroundFilter(),
        const MusicTimer(),
      ]),
    );
    // );
  }
}
