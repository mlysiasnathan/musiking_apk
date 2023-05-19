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
    final songData = Provider.of<SongsLocal>(context, listen: false);
    final mediaQuery = MediaQuery.of(context).size;
    final seekBarDataStream = songData.seekBarDataStream;
    final audioPlayer = songData.audioPlayer;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 50),
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
              borderRadius: BorderRadius.circular(30),
              child: Consumer<SongsLocal>(
                builder: (ctx, songData, _) => QueryArtworkWidget(
                  id: songData.currentPlaylist[songData.currentIndex].id,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.zero,
                  artworkHeight: mediaQuery.height * 0.45,
                  artworkWidth: mediaQuery.height * 0.45,
                  artworkFit: BoxFit.cover,
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          StreamBuilder<SeekBarData>(
            stream: seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return Consumer<SongsLocal>(
                builder: (ctx, songData, _) => SeekBar(
                  position: positionData?.position ?? Duration.zero,
                  duration: positionData?.duration ?? Duration.zero,
                  onChangedEnd: audioPlayer.seek,
                ),
              );
            },
          ),
          const MusicControllers(),
          const SizedBox(height: 10),
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
                        //             color: Colors.deepOrange,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //       maxLines: 2,
                        //       overflow: TextOverflow.ellipsis),
                        // ),
                        title: Consumer<SongsLocal>(
                          builder: (ctx, songData, _) => Text(
                              songData.songs[songData.currentIndex].displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.deepOrange,
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
                              songData.songs[songData.currentIndex].album
                                  .toString(),
                              style: const TextStyle(color: Colors.deepOrange),
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
                                    color: Colors.deepOrange,
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
                              songData.songs[songData.currentIndex].uri
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: Colors.deepOrange,
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
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      elevation: 10,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.8),
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(
                        'Playlist of ${songData.currentPlaylist.length} song${songData.currentPlaylist.length > 1 ? 's' : ''}',
                        style: const TextStyle(color: Colors.deepOrange),
                      ),
                      content: SizedBox(
                        height: mediaQuery.height * 0.50,
                        width: mediaQuery.width,
                        child: ListView.builder(
                          itemCount: songData.currentPlaylist.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                songData.audioPlayer.setAudioSource(
                                  songData.initializePlaylist(
                                      songData.currentPlaylist),
                                  initialIndex: index,
                                );
                                songData.audioPlayer.play();
                                songData.setCurrentSong(index);
                                songData.generateColors();
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Consumer<SongsLocal>(
                                builder: (ctx, songData, _) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: index == songData.currentIndex
                                        ? Colors.deepOrange
                                        : null,
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const SizedBox(width: 4),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: QueryArtworkWidget(
                                          id: songData
                                              .currentPlaylist[index].id,
                                          type: ArtworkType.AUDIO,
                                          artworkBorder: BorderRadius.zero,
                                          artworkWidth: 42,
                                          artworkHeight: 42,
                                          nullArtworkWidget: ClipRRect(
                                            child: Container(
                                              color: Colors.white,
                                              child: Image.asset(
                                                color: Colors.deepOrange,
                                                'assets/musiccovers/musiking_logo.png',
                                                width: 42,
                                                height: 42,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          '${songData.currentPlaylist.indexOf(songData.songs[index]) + 1} - \t${songData.currentPlaylist[index].title}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: index ==
                                                        songData.currentIndex
                                                    ? null
                                                    : Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        splashRadius: 23,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.more_horiz_outlined,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ],
                    ),
                  );
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
