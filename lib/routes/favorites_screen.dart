import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  static const routeName = '/favorites-songs';

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
