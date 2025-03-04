import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  static const routeName = '/favorites-songs';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ThemeData theme = Theme.of(context);
    final songData = Provider.of<Songs>(context);
    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null
          ? songData.saveCurrentSong(songData.currentPlaylist[index])
          : null;
    });

    return SingleChildScrollView(
      key: const ValueKey('favorites'),
      child: Padding(
        padding: const EdgeInsets.all(19.9),
        child: Column(
          children: [
            const SizedBox(height: 10),
            PlayOrShuffleSwitch(playLists: songData.favorites),
            const SizedBox(height: 10),
            if (songData.favorites.isEmpty)
              Column(
                children: [
                  Text(
                    'No favorite song',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: theme.colorScheme.background,
                    ),
                  ),
                  const Icon(
                    Icons.heart_broken,
                    size: 120,
                  ),
                ],
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: songData.favorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: SongCardOne(
                      playLists: songData.favorites,
                      song: songData.favorites[index],
                      index: index,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
