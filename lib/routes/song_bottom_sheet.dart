import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class SongBottomSheet extends StatelessWidget {
  const SongBottomSheet({super.key});
  static const routeName = '/song_screen';

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<Songs>(context, listen: false);
    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null ? songData.setCurrentSong(index) : null;
    });
    return Stack(
      children: [
        Consumer<Songs>(
          builder: (ctx, songData, child) => QueryArtworkWidget(
            id: songData.currentPlaylist[songData.currentIndex].id,
            type: ArtworkType.AUDIO,
            artworkFit: BoxFit.cover,
            artworkHeight: double.infinity,
            artworkWidth: double.infinity,
            artworkBorder: BorderRadius.zero,
            keepOldArtwork: true,
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
        const MusicUi(),
      ],
    );
  }
}
