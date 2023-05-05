import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  static const routeName = '/favorites-songs';
  String _formatDuration(int duration) {
    int h, m, s;
    h = duration ~/ 3600;
    m = ((duration - h * 3600)) ~/ 60;
    s = duration - (h * 3600) - (m * 60);

    // String hours = h.toString().length < 2 ? "0$h" : h.toString();
    String minutes = m.toString().length < 2 ? "0$m" : m.toString();
    String seconds = s.toString().length < 2 ? "0$s" : s.toString();

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context, listen: false);
    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null ? songData.setCurrentSong(index) : null;
    });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(19.9),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const _PlayOrShuffleSwitch(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: songData.songs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await songData.audioPlayer.setAudioSource(
                          songData.initializePlaylist(songData.songs),
                          initialIndex: index,
                        );
                        await songData.audioPlayer.play();
                        songData.setCurrentSong(index);
                        // songData.generateColors();
                      },
                      child: ListTile(
                        leading:
                            Consumer<SongsLocal>(builder: (ctx, songData, _) {
                          if (songData.songs[index].title ==
                              songData.currentSong) {
                            return const Icon(Icons.play_arrow,
                                color: Colors.white, size: 16);
                          } else {
                            return Text(
                              '${index + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            );
                          }
                        }),
                        title: Text(
                          songData.songs[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            '${songData.songs[index].album} - ${_formatDuration(songData.songs[index].duration as int)}'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayOrShuffleSwitch extends StatelessWidget {
  const _PlayOrShuffleSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.7;
    final songData = Provider.of<SongsLocal>(context);

    return StreamBuilder<SequenceState?>(
      stream: songData.audioPlayer.sequenceStateStream,
      builder: (context, index) {
        return GestureDetector(
          onTap: () async {
            if (songData.currentSong == 'Click to play') {
              await songData.audioPlayer.setAudioSource(
                songData.initializePlaylist(songData.songs),
                initialIndex: 0,
              );
            }
            await songData.audioPlayer.play();
            songData.audioPlayer.shuffleModeEnabled
                ? songData.audioPlayer.setShuffleModeEnabled(false)
                : songData.audioPlayer.setShuffleModeEnabled(true);
            songData.generateColors();
          },
          child: Container(
            height: 40,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 100),
                  left: !songData.audioPlayer.shuffleModeEnabled
                      ? 0
                      : width * 0.48,
                  right: !songData.audioPlayer.shuffleModeEnabled
                      ? width * 0.48
                      : 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    height: 40,
                    width: width * 0.40,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Play',
                              style: TextStyle(
                                color: !songData.audioPlayer.shuffleModeEnabled
                                    ? Colors.white
                                    : Colors.orange,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.play_circle_outline,
                            color: !songData.audioPlayer.shuffleModeEnabled
                                ? Colors.white
                                : Colors.orange,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Shuffle',
                              style: TextStyle(
                                color: !songData.audioPlayer.shuffleModeEnabled
                                    ? Colors.orange
                                    : Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            CupertinoIcons.shuffle,
                            color: !songData.audioPlayer.shuffleModeEnabled
                                ? Colors.orange
                                : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
