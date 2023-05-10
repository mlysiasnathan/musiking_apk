import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider.dart';
import '../widgets/seekbar.dart';
import '../widgets/music_controllers.dart';

class MusicTimer extends StatelessWidget {
  const MusicTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<Songs>(context);
    final mediaQuery = MediaQuery.of(context);
    final song = songData.currentSong;
    final seekBarDataStream = songData.seekBarDataStream;
    final audioPlayer = songData.audioPlayer;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 47),
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
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                song.coverUrl,
                height: mediaQuery.size.height * 0.45,
                width: mediaQuery.size.height * 0.45,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            song.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Text(
            song.descriptions,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          StreamBuilder<SeekBarData>(
            stream: seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                position: positionData?.position ?? Duration.zero,
                duration: positionData?.duration ?? Duration.zero,
                onChangedEnd: audioPlayer.seek,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black.withOpacity(0.8),
                icon: const Icon(
                  CupertinoIcons.info_circle,
                  color: Colors.white,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: ListTile(
                        leading:
                            const Icon(Icons.music_note, color: Colors.white),
                        title: Text(song.title,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.album, color: Colors.white),
                        title: Text(song.descriptions,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading:
                            const Icon(Icons.folder_open, color: Colors.white),
                        title: Text(song.musicUrl,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true),
                      ),
                    ),
                  ];
                },
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      backgroundColor: Colors.black.withOpacity(0.8),
                      elevation: 0,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text(
                        'Playlist and Queue',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: songData.songs.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                songData.clickToPlay(songData.songs[i]);
                                songData.generateColors();
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                        songData.songs[i] ==
                                                songData.currentSong
                                            ? Icons.play_arrow
                                            : null,
                                        color: Colors.white,
                                        size: 16),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        songData.songs[i].coverUrl,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            songData.songs[i].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${songData.songs.indexOf(songData.songs[i]) + 1}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                            height: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      splashRadius: 23,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.more_horiz_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
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
                            style: TextStyle(color: Colors.white),
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
