import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../routes/refresh_screen.dart';
import '../widgets.dart';

class AllSongsWgt extends StatelessWidget {
  const AllSongsWgt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final songData = Provider.of<Songs>(context, listen: false);
    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null
          ? songData.saveCurrentSong(songData.currentPlaylist[index])
          : null;
    });

    return Consumer<Songs>(
      builder: (ctx, songData, _) => Padding(
        padding: const EdgeInsets.only(left: 19, right: 19, bottom: 30),
        child: songData.songs.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SectionHeader(
                    title: 'No Songs found',
                    action: () =>
                        Navigator.pushNamed(context, RefreshScreen.routeName),
                    actionText: 'Refresh',
                    afterActionText: 'Refreshed',
                  ),
                  const SizedBox(height: 20),
                  Icon(
                    Icons.do_not_disturb_alt,
                    color: theme.primaryColorLight,
                    size: 50,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Refresh the Playlist',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  SectionHeader(
                    title: 'Trending Music',
                    action: () =>
                        Navigator.pushNamed(context, RefreshScreen.routeName),
                    actionText: songData.songs.length ==
                            songData.currentPlaylist.length
                        ? 'View more'
                        : 'More ${songData.songs.length - songData.currentPlaylist.length} songs',
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    addRepaintBoundaries: true,
                    addAutomaticKeepAlives: true,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: songData.currentPlaylist.length,
                    itemBuilder: (context, index) => SongCardOne(
                      playLists: songData.currentPlaylist,
                      key: ValueKey(index),
                      song: songData.currentPlaylist[index],
                      index: index,
                      showBigSize: true,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
