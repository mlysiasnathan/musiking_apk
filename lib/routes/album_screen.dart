import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../helpers/constant.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key}) : super(key: key);
  static const routeName = '/playlist';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    final playlist = ModalRoute.of(context)?.settings.arguments as AlbumModel;
    final List<SongModel> songs = Provider.of<Songs>(context, listen: false)
        .songs
        .where((song) => song.albumId == playlist.id)
        .toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
      ),
      child: Scaffold(
        floatingActionButton: const MusicFloating(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: FittedBox(
            child: Text(
              playlist.album,
              style: theme.textTheme.headlineSmall!.copyWith(
                color: theme.colorScheme.background,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: playlist.id,
                    child: QueryArtworkWidget(
                      id: playlist.id,
                      artworkBorder: BorderRadius.circular(20),
                      type: ArtworkType.ALBUM,
                      artworkFit: BoxFit.cover,
                      artworkWidth: deviceSize.width * 0.5,
                      artworkHeight: deviceSize.width * 0.5,
                      keepOldArtwork: true,
                      nullArtworkWidget: Container(
                        width: deviceSize.width * 0.43,
                        height: deviceSize.width * 0.43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: theme.colorScheme.background.withOpacity(0.6),
                        ),
                        child: Icon(
                          Icons.album,
                          size: 150,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // _PlaylistInfo(playlist: playlist),
                const SizedBox(height: 10),
                PlayOrShuffleSwitch(playLists: songs),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: playlist.numOfSongs,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SongCardOne(
                          playLists: songs,
                          song: songs[index],
                          index: index,
                          showIndex: true,
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
