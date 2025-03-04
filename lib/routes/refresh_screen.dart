import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../providers/playlists_provider_local.dart';
import '../providers/songs_provider.dart';
import '../widgets/song/music_floating.dart';
import '../widgets/song/song_card_one.dart';

class RefreshScreen extends StatelessWidget {
  const RefreshScreen({super.key});

  static const routeName = '/refresh-screen';

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery audioQuery = OnAudioQuery();
    final ThemeData theme = Theme.of(context);
    final songData = Provider.of<Songs>(context);
    final deviceSize = MediaQuery.of(context).size;
    final playlistData = Provider.of<Playlists>(context);
    void refresh() {
      songData.refreshSongs();
      playlistData.refreshPlaylists();
    }

    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null
          ? songData.saveCurrentSong(songData.currentPlaylist[index])
          : null;
    });

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
            'All Songs',
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.colorScheme.background,
            ),
          ),
          actions: [
            IconButton(
              onPressed: refresh,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 70,
                    width: deviceSize.width * 0.45,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            width: 67,
                            height: 67,
                            color:
                                theme.colorScheme.background.withOpacity(0.7),
                            child: Icon(
                              Icons.album,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            playlistData.playlists.isNotEmpty
                                ? Text(
                                    playlistData.playlists.length.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        theme.textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.background,
                                    ),
                                  )
                                : FutureBuilder<List<AlbumModel>>(
                                    future: audioQuery.queryAlbums(
                                      sortType: null,
                                      ignoreCase: true,
                                      uriType: UriType.EXTERNAL,
                                      orderType: OrderType.ASC_OR_SMALLER,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text(
                                          "Loading...",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.background,
                                          ),
                                        );
                                      }
                                      if (snapshot.data!.isEmpty) {
                                        return Text(
                                          "Not Found",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.background,
                                          ),
                                        );
                                      }
                                      Future.delayed(
                                        Duration.zero,
                                        () => playlistData.getAlbumsList(
                                            albumsList: snapshot.data!),
                                      );
                                      return Text(
                                        snapshot.data!.length.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.background,
                                        ),
                                      );
                                    }),
                            Text(
                              'Albums',
                              maxLines: 1,
                              style: theme.textTheme.labelSmall!.copyWith(
                                color: theme.colorScheme.background,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: deviceSize.width * 0.45,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            width: 67,
                            height: 67,
                            color:
                                theme.colorScheme.background.withOpacity(0.7),
                            child: Icon(
                              Icons.music_note,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            songData.songs.isNotEmpty
                                ? Text(
                                    songData.songs.length.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        theme.textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.background,
                                    ),
                                  )
                                : Text(
                                    "Loading...",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        theme.textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.background,
                                    ),
                                  ),
                            Text(
                              'songs',
                              maxLines: 1,
                              style: theme.textTheme.labelSmall!.copyWith(
                                color: theme.colorScheme.background,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: songData.songs.isEmpty
                    ? FutureBuilder<List<SongModel>>(
                        future: audioQuery.querySongs(
                          sortType: null,
                          ignoreCase: true,
                          uriType: UriType.EXTERNAL,
                          orderType: OrderType.ASC_OR_SMALLER,
                        ),
                        builder: (context, snapshots) {
                          if (snapshots.connectionState ==
                              ConnectionState.waiting) {
                            return ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) =>
                                  const SongCardLoading(),
                            );
                          }
                          if (snapshots.data!.isEmpty) {
                            return Center(
                              child: Text(
                                "Songs Not Found",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.background,
                                ),
                              ),
                            );
                          }
                          Future.delayed(
                            Duration.zero,
                            () => songData.getSongsList(
                              songsList: snapshots.data!,
                            ),
                          );
                          return ListView.builder(
                            shrinkWrap: true,
                            addRepaintBoundaries: true,
                            addAutomaticKeepAlives: true,
                            itemCount: snapshots.data!.length,
                            itemBuilder: (context, index) => SongCardOne(
                              playLists: snapshots.data!,
                              key: ValueKey(index),
                              song: snapshots.data![index],
                              index: index,
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        addRepaintBoundaries: true,
                        addAutomaticKeepAlives: true,
                        itemCount: songData.songs.length,
                        itemBuilder: (context, index) => SongCardOne(
                          playLists: songData.songs,
                          key: ValueKey(index),
                          song: songData.songs[index],
                          index: index,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
