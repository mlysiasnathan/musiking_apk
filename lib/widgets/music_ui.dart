import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import '../models/models.dart';

class MusicUi extends StatelessWidget {
  const MusicUi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColorLight = theme.primaryColorLight;
    final songData = Provider.of<Songs>(context, listen: false);
    final mediaQuery = MediaQuery.of(context).size;
    final seekBarDataStream = songData.seekBarDataStream;
    final audioPlayer = songData.audioPlayer;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.height * 0.020,
          vertical: mediaQuery.height * 0.025),
      // padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     TextButton.icon(
          //       onPressed: () => Navigator.pop(context),
          //       label: const Text(
          //         'Close',
          //         style: TextStyle(color: theme.colorScheme.background),
          //       ),
          //       icon: const Icon(
          //         Icons.keyboard_arrow_down_outlined,
          //         color: theme.colorScheme.background,
          //       ),
          //     ),
          //   ],
          // ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              elevation: 20,
              child: ClipRRect(
                key: ValueKey(
                    songData.currentPlaylist[songData.currentIndex].id),
                borderRadius: BorderRadius.circular(30),
                child: Consumer<Songs>(
                  builder: (ctx, songData, _) => Hero(
                    tag: songData.currentPlaylist[songData.currentIndex].id,
                    child: QueryArtworkWidget(
                      id: songData.currentPlaylist[songData.currentIndex].id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.zero,
                      artworkHeight: mediaQuery.height * 0.45,
                      artworkWidth: mediaQuery.height * 0.45,
                      artworkFit: BoxFit.cover,
                      keepOldArtwork: true,
                      nullArtworkWidget: ClipRRect(
                        child: Image.asset(
                          'assets/musiccovers/musiking_logo.jpg',
                          width: mediaQuery.height * 0.45,
                          height: mediaQuery.height * 0.45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: mediaQuery.height * 0.023),
          Consumer<Songs>(
            builder: (ctx, songData, _) => Text(
              songData.currentPlaylist[songData.currentIndex].title,
              style: theme.textTheme.headlineSmall!.copyWith(
                color: theme.colorScheme.background,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: mediaQuery.height * 0.023),
          Consumer<Songs>(
            builder: (ctx, songData, _) => Text(
              songData.currentPlaylist[songData.currentIndex].artist ==
                      '<unknown>'
                  ? 'Unknown Artist'
                  : songData.currentPlaylist[songData.currentIndex].artist
                      .toString(),
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.background),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: mediaQuery.height * 0.023),
          StreamBuilder<SeekBarData>(
            stream: seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return Consumer<Songs>(
                builder: (ctx, songData, _) => SeekBar(
                  position: positionData?.position ?? songData.position,
                  duration: positionData?.duration ?? Duration.zero,
                  onChangedEnd: audioPlayer.seek,
                ),
              );
            },
          ),
          const MusicControllers(),
          SizedBox(height: mediaQuery.height * 0.023),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PopupMenuButton(
                elevation: 5,
                tooltip: 'Get more Info about this song',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: theme.colorScheme.background.withOpacity(0.8),
                icon: Icon(
                  CupertinoIcons.info_circle,
                  color: theme.colorScheme.background,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.music_note),
                        // trailing: Consumer<Songs>(
                        //   builder: (ctx, songData, _) => Text(
                        //       songData.songs[songData.currentIndex].size
                        //           .toString(),
                        //       style: theme
                        //           .textTheme
                        //           .bodyLarge!
                        //           .copyWith(
                        //             color: primaryColorLight,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //       maxLines: 2,
                        //       overflow: TextOverflow.ellipsis),
                        // ),
                        title: Consumer<Songs>(
                          builder: (ctx, songData, _) => Text(
                              songData.currentPlaylist[songData.currentIndex]
                                  .displayName,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: primaryColorLight,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.album),
                        title: Consumer<Songs>(
                          builder: (ctx, songData, _) => Text(
                              songData
                                  .currentPlaylist[songData.currentIndex].album
                                  .toString(),
                              style: TextStyle(color: primaryColorLight),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.person_2),
                        title: Consumer<Songs>(
                          builder: (ctx, songData, _) => Text(
                              songData.currentPlaylist[songData.currentIndex]
                                          .artist ==
                                      '<unknown>'
                                  ? 'Unknown Artist'
                                  : songData
                                      .currentPlaylist[songData.currentIndex]
                                      .artist
                                      .toString(),
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: primaryColorLight,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.folder_open),
                        title: Consumer<Songs>(
                          builder: (ctx, songData, _) => Text(
                              songData
                                  .currentPlaylist[songData.currentIndex].data
                                  .toString(),
                              style: theme.textTheme.labelMedium!.copyWith(
                                color: primaryColorLight,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true),
                        ),
                      ),
                    ),
                  ];
                },
              ),
              IconButton(
                tooltip: 'Add This song to favorite Playlist',
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.heart,
                  color: theme.colorScheme.background,
                ),
              ),
              IconButton(
                tooltip: 'Show the current Playlist',
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                  songData.autoScroll();
                },
                icon: Icon(
                  CupertinoIcons.square_list,
                  color: theme.colorScheme.background,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
