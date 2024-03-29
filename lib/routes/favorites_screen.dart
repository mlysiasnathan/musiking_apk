import 'package:flutter/material.dart';
import 'package:musiking/widgets/new_app_bar.dart';
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
    final songData = Provider.of<Songs>(context, listen: false);
    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null ? songData.setCurrentSong(index) : null;
    });

    return SingleChildScrollView(
      key: const ValueKey('favorites'),
      child: Padding(
        padding: const EdgeInsets.all(19.9),
        child: Column(
          children: [
            const NewAppBar(),
            const SizedBox(height: 10),
            const PlayOrShuffleSwitch(),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: songData.songs.length >= 3 ? 3 : 0,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SongCardTwo(
                      song: songData.songs[index],
                      index: index,
                      songs: songData.songs,
                    ),
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
