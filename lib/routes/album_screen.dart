import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key}) : super(key: key);
  static const routeName = '/playlist';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    final Color primaryColorDark = theme.primaryColorDark;
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
          colors: [
            primaryColorDark.withOpacity(0.8),
            primaryColor.withOpacity(0.8),
          ],
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
          title: const Text('Playlist'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _PlaylistInfo(playlist: playlist),
                const SizedBox(height: 20),
                const PlayOrShuffleSwitch(),
                const SizedBox(height: 10),
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
    final Color primaryColorLight = theme.primaryColorLight;
    final mediaQuery = MediaQuery.of(context).size;
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
              artworkWidth: mediaQuery.height * 0.3,
              artworkHeight: mediaQuery.height * 0.3,
              keepOldArtwork: true,
              nullArtworkWidget: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: theme.colorScheme.background.withOpacity(0.7),
                  child: Image.asset(
                    color: primaryColorLight,
                    'assets/musiccovers/musiking_logo.png',
                    width: mediaQuery.height * 0.3,
                    height: mediaQuery.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        FittedBox(
          child: Text(
            playlist.album,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.background,
                ),
          ),
        )
      ],
    );
  }
}
