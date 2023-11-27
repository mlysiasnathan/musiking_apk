import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MusicControllers extends StatelessWidget {
  const MusicControllers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColorLight = theme.primaryColorLight;
    final songData = Provider.of<Songs>(context);
    final audioPlayer = songData.audioPlayer;
    void showToast(BuildContext ctx, String message) {
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          content: Text(message, style: TextStyle(color: theme.primaryColor)),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return CircleAvatar(
              backgroundColor: audioPlayer.shuffleModeEnabled
                  ? theme.colorScheme.background
                  : Colors.transparent,
              child: IconButton(
                tooltip: 'Shuffle Mode',
                onPressed: () {
                  audioPlayer.shuffleModeEnabled
                      ? audioPlayer.setShuffleModeEnabled(false)
                      : audioPlayer.setShuffleModeEnabled(true);
                  showToast(
                      context,
                      songData.audioPlayer.shuffleModeEnabled
                          ? 'Shuffle mode Enabled'
                          : 'Shuffle mode Disabled');
                },
                icon: Icon(CupertinoIcons.shuffle,
                    color: audioPlayer.shuffleModeEnabled
                        ? primaryColorLight
                        : theme.colorScheme.background),
                iconSize: 20,
              ),
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              tooltip: songData.audioPlayer.currentIndex != null
                  ? songData.audioPlayer.currentIndex! > 0
                      ? songData
                          .currentPlaylist[songData.currentIndex - 1].title
                      : 'This is the first song of the playlist'
                  : null,
              onPressed: songData.prev,
              icon: Icon(
                CupertinoIcons.backward_end_fill,
                color: theme.colorScheme.background,
              ),
              iconSize: 30,
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState = playerState!.processingState;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  height: 64,
                  width: 64,
                  margin: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.background,
                  ),
                );
              } else if (!audioPlayer.playing) {
                return IconButton(
                  color: theme.colorScheme.background,
                  iconSize: 70,
                  onPressed: () async {
                    if (songData.currentSong == 'Click to play' ||
                        songData.audioPlayer.currentIndex == null) {
                      songData.currentPlaylist = songData.songs;
                      await songData.audioPlayer.setAudioSource(
                        songData.initializePlaylist(songData.currentPlaylist),
                        initialIndex: songData.currentIndex,
                      );
                      songData.setCurrentSong(songData.currentIndex);
                    }
                    audioPlayer.play();
                  },
                  icon: const Icon(
                    CupertinoIcons.play_circle_fill,
                  ),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  color: theme.colorScheme.background,
                  iconSize: 70,
                  onPressed: () {
                    audioPlayer.pause();
                  },
                  icon: const Icon(
                    CupertinoIcons.pause_circle_fill,
                  ),
                );
              } else if (processingState == ProcessingState.completed) {
                return IconButton(
                  color: theme.colorScheme.background,
                  iconSize: 70,
                  onPressed: () {
                    audioPlayer.pause();
                  },
                  icon: const Icon(
                    CupertinoIcons.pause_circle_fill,
                  ),
                );
              } else {
                return IconButton(
                  color: theme.colorScheme.background,
                  iconSize: 75,
                  onPressed: () {
                    audioPlayer.seek(
                      Duration.zero,
                      index: audioPlayer.effectiveIndices!.first,
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.memories,
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.background,
                ),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              tooltip: songData.audioPlayer.currentIndex != null
                  ? songData.audioPlayer.currentIndex! <
                          songData.currentPlaylist.length - 1
                      ? songData
                          .currentPlaylist[songData.currentIndex + 1].title
                      : 'End of the playlist'
                  : null,
              onPressed: songData.next,
              icon: Icon(
                CupertinoIcons.forward_end_fill,
                color: theme.colorScheme.background,
              ),
              iconSize: 30,
            );
          },
        ),
        StreamBuilder<LoopMode>(
          stream: audioPlayer.loopModeStream,
          builder: (context, snapshot) {
            final loopMode = snapshot.data;
            if (loopMode == LoopMode.one) {
              return CircleAvatar(
                backgroundColor: theme.colorScheme.background,
                child: IconButton(
                  tooltip: 'Looping to This SONG only',
                  onPressed: () {
                    showToast(context, 'Loop mode ALL');
                    audioPlayer.setLoopMode(LoopMode.all);
                  },
                  icon: const Icon(
                    Icons.refresh,
                  ),
                  color: primaryColorLight,
                  iconSize: 20,
                ),
              );
            } else if (loopMode == LoopMode.all) {
              return CircleAvatar(
                backgroundColor: theme.colorScheme.background,
                child: IconButton(
                  tooltip: 'Looping to ALL SONGS',
                  onPressed: () {
                    showToast(context, 'Loop mode OFF');
                    audioPlayer.setLoopMode(LoopMode.off);
                  },
                  icon: const Icon(
                    Icons.loop_outlined,
                  ),
                  color: primaryColorLight,
                  iconSize: 20,
                ),
              );
            }
            return IconButton(
              tooltip: 'No Looping',
              onPressed: () {
                showToast(context, 'Loop mode ONE');
                audioPlayer.setLoopMode(LoopMode.one);
              },
              icon: const Icon(
                Icons.loop_outlined,
              ),
              color: theme.colorScheme.background,
              iconSize: 20,
            );
          },
        ),
      ],
    );
  }
}
