import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';
import '../widgets/play_or_shuffle.dart';
import '../widgets/song_card_for_playlist.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  static const routeName = '/favorites-songs';
  String _formatDuration(int duration) {
    int h, m, s;
    h = duration ~/ 3600;
    m = ((duration - h * 3600)) ~/ 60;
    s = duration - (h * 3600) - (m * 60);

    // String hours = h.toString().length < 2 ? "0$h" : h.toString();
    String minutes = m.toString().length < 2 ? "0$m" : m.toString();
    String seconds = s.toString().length < 2 ? "0$s" : s.toString();

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context, listen: false);
    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null ? songData.setCurrentSong(index) : null;
    });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(19.9),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const PlayOrShuffleSwitch(),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: songData.songs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SongCardForPlaylist(
                        song: songData.songs[index],
                        index: index,
                        songs: songData.songs),
                    const Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
