import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiking/models/songs_provider_local.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../widgets/background_filter_local.dart';
import '../widgets/music_timer_local.dart';

class SongBottomSheet extends StatelessWidget {
  const SongBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context, listen: false);
    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null ? songData.setCurrentSong(index) : null;
    });
    return Stack(children: const [
      // Consumer<SongsLocal>(
      //   builder: (ctx, songData, child) => QueryArtworkWidget(
      //     id: songData.songs[songData.currentIndex].id,
      //     type: ArtworkType.AUDIO,
      //     artworkBorder: BorderRadius.zero,
      //     nullArtworkWidget:
      //         const Icon(CupertinoIcons.music_note_2, color: Colors.white),
      //   ),
      // ),
      BackgroundFilter(),
      MusicTimer(),
    ]);
    // );
  }
}
