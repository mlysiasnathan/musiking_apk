import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import '../models/models.dart';

class MusicTimer extends StatelessWidget {
  const MusicTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColorLight = Theme.of(context).primaryColorLight;
    final songData = Provider.of<SongsLocal>(context, listen: false);
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
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       icon: const Icon(
          //         Icons.keyboard_arrow_down_outlined,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ],
          // ),
          Center(
            child: ClipRRect(
              key: ValueKey(songData.currentPlaylist[songData.currentIndex].id),
              borderRadius: BorderRadius.circular(30),
              child: Consumer<SongsLocal>(
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
          SizedBox(height: mediaQuery.height * 0.023),
          Consumer<SongsLocal>(
            builder: (ctx, songData, _) => Text(
              songData.currentPlaylist[songData.currentIndex].title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: mediaQuery.height * 0.023),
          Consumer<SongsLocal>(
            builder: (ctx, songData, _) => Text(
              songData.currentPlaylist[songData.currentIndex].artist ==
                      '<unknown>'
                  ? 'Unknown Artist'
                  : songData.currentPlaylist[songData.currentIndex].artist
                      .toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: mediaQuery.height * 0.023),
          StreamBuilder<SeekBarData>(
            stream: seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return Consumer<SongsLocal>(
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
                color: Colors.white.withOpacity(0.8),
                icon: const Icon(
                  CupertinoIcons.info_circle,
                  color: Colors.white,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.music_note),
                        // trailing: Consumer<SongsLocal>(
                        //   builder: (ctx, songData, _) => Text(
                        //       songData.songs[songData.currentIndex].size
                        //           .toString(),
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .bodyLarge!
                        //           .copyWith(
                        //             color: primaryColorLight,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //       maxLines: 2,
                        //       overflow: TextOverflow.ellipsis),
                        // ),
                        title: Consumer<SongsLocal>(
                          builder: (ctx, songData, _) => Text(
                              songData.currentPlaylist[songData.currentIndex]
                                  .displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
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
                        title: Consumer<SongsLocal>(
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
                        title: Consumer<SongsLocal>(
                          builder: (ctx, songData, _) => Text(
                              songData.currentPlaylist[songData.currentIndex]
                                          .artist ==
                                      '<unknown>'
                                  ? 'Unknown Artist'
                                  : songData
                                      .currentPlaylist[songData.currentIndex]
                                      .artist
                                      .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
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
                        title: Consumer<SongsLocal>(
                          builder: (ctx, songData, _) => Text(
                              songData
                                  .currentPlaylist[songData.currentIndex].data
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
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
                icon: const Icon(
                  CupertinoIcons.heart,
                  color: Colors.white,
                ),
              ),
              IconButton(
                tooltip: 'Show the current Playlist',
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                  songData.autoScroll();
                },
                icon: const Icon(
                  CupertinoIcons.square_list,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
