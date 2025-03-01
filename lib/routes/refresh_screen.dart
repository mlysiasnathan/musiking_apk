import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../providers/playlists_provider_local.dart';
import '../providers/songs_provider.dart';
import '../widgets/song/song_card_one.dart';

class RefreshScreen extends StatelessWidget {
  const RefreshScreen({super.key});
  static const routeName = '/refresh-screen';

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery audioQuery = OnAudioQuery();
    final ThemeData theme = Theme.of(context);
    final songData = Provider.of<Songs>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    final playlistData = Provider.of<Playlists>(context, listen: false);
    return Scaffold(
      backgroundColor: theme.colorScheme.secondary,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {},
        label: const Text("Refresh"),
        icon: const Icon(Icons.refresh_sharp),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              height: 10,
              width: 10,
              child: FutureBuilder<List<SongModel>>(
                future: audioQuery.querySongs(
                  sortType: null,
                  ignoreCase: true,
                  uriType: UriType.EXTERNAL,
                  orderType: OrderType.ASC_OR_SMALLER,
                ),
                builder: (context, items) {
                  if (items.data == null) {
                    return const CircularProgressIndicator(color: Colors.white);
                  }
                  return const SizedBox();
                },
              ),
            ),
          )
        ],
        title: Text(
          'Refresh songs list',
          style: theme.textTheme.headlineSmall!.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: deviceSize.width * 0.45,
                    margin: const EdgeInsets.all(3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 50,
                            height: 50,
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
                                        orderType: OrderType.ASC_OR_SMALLER),
                                    builder: (context, items) {
                                      if (items.data == null) {
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
                                      if (items.data!.isEmpty) {
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
                                            albumsList: items.data!),
                                      );
                                      return Text(
                                        items.data!.length.toString(),
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
                    height: 50,
                    width: deviceSize.width * 0.45,
                    margin: const EdgeInsets.all(3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 50,
                            height: 50,
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
                                : FutureBuilder<List<SongModel>>(
                                    future: audioQuery.querySongs(
                                      sortType: null,
                                      ignoreCase: true,
                                      uriType: UriType.EXTERNAL,
                                      orderType: OrderType.ASC_OR_SMALLER,
                                    ),
                                    builder: (context, items) {
                                      if (items.data == null) {
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
                                      if (items.data!.isEmpty) {
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
                                      return Text(
                                        items.data!.length.toString(),
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
            ),
            Consumer<Songs>(
              builder: (ctx, songData, _) => Expanded(
                child: songData.songs.isEmpty
                    ? FutureBuilder<List<SongModel>>(
                        future: audioQuery.querySongs(
                          sortType: null,
                          ignoreCase: true,
                          uriType: UriType.EXTERNAL,
                          orderType: OrderType.ASC_OR_SMALLER,
                        ),
                        builder: (context, items) {
                          if (items.data == null) {
                            return ListView.builder(
                              shrinkWrap: true,
                              addRepaintBoundaries: true,
                              addAutomaticKeepAlives: true,
                              padding: const EdgeInsets.only(top: 4),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 50,
                                  margin: const EdgeInsets.all(3),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              },
                            );
                          }
                          if (items.data!.isEmpty) {
                            return Center(
                              child: Text(
                                "Not Found",
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
                            () => songData.getSongsList(songsList: items.data!),
                          );
                          return ListView.builder(
                            shrinkWrap: true,
                            addRepaintBoundaries: true,
                            addAutomaticKeepAlives: true,
                            itemCount: items.data!.length,
                            itemBuilder: (context, index) => SongCardOne(
                              key: ValueKey(index),
                              song: items.data![index],
                              index: items.data![index].id,
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
                          key: ValueKey(index),
                          song: songData.songs[index],
                          index: songData.songs[index].id,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
