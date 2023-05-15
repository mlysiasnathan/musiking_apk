import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';
import '../widgets/play_or_shuffle.dart';
import '../widgets/pre_playing_floating_action_bar_local.dart';
import '../widgets/song_card_for_playlist.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);
  static const routeName = '/playlist';

  @override
  Widget build(BuildContext context) {
    final playlist = ModalRoute.of(context)?.settings.arguments as AlbumModel;
    final List<SongModel> songs =
        Provider.of<SongsLocal>(context, listen: false)
            .songs
            .where((song) => song.albumId == playlist.id)
            .toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red.withOpacity(0.8),
            Colors.orange.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        floatingActionButton: const PrePlayingSong(),
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
                        SongCardForPlaylist(
                            song: songs[index], index: index, songs: songs),
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
    final mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: QueryArtworkWidget(
            id: playlist.id,
            artworkBorder: BorderRadius.circular(20),
            type: ArtworkType.ALBUM,
            artworkFit: BoxFit.cover,
            artworkWidth: mediaQuery.height * 0.3,
            artworkHeight: mediaQuery.height * 0.3,
            nullArtworkWidget: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white.withOpacity(0.7),
                child: Image.asset(
                  color: Colors.deepOrange,
                  'assets/musiccovers/musiking_logo.png',
                  width: mediaQuery.height * 0.3,
                  height: mediaQuery.height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          playlist.album,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
