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
          title: Text(
            'Album',
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.colorScheme.background,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _PlaylistInfo(playlist: playlist),
                const SizedBox(height: 10),
                const PlayOrShuffleSwitch(),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: playlist.numOfSongs,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SongCardTwo(
                          song: songs[index],
                          index: index,
                          songs: songs,
                        ),
                        const Divider(color: Colors.white),
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

class _PlaylistInfo extends StatelessWidget {
  const _PlaylistInfo({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final AlbumModel playlist;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    return Column(
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
              artworkWidth: deviceSize.height * 0.3,
              artworkHeight: deviceSize.height * 0.3,
              keepOldArtwork: true,
              nullArtworkWidget: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: theme.colorScheme.background.withOpacity(0.7),
                  child: Image.asset(
                    color: theme.primaryColor,
                    imageList[2],
                    width: deviceSize.height * 0.3,
                    height: deviceSize.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            playlist.album,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.colorScheme.background,
            ),
          ),
        )
      ],
    );
  }
}
