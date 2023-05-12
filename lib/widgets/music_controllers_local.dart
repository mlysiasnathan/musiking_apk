import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';

class MusicControllers extends StatelessWidget {
  const MusicControllers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context);
    final audioPlayer = songData.audioPlayer;
    void showToast(BuildContext ctx, String message) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              tooltip: 'Shuffle Mode',
              onPressed: () {
                showToast(
                    context,
                    songData.audioPlayer.shuffleModeEnabled
                        ? 'Shuffle mode Disabled'
                        : 'Shuffle mode Enabled');
                audioPlayer.shuffleModeEnabled
                    ? audioPlayer.setShuffleModeEnabled(false)
                    : audioPlayer.setShuffleModeEnabled(true);
              },
              icon: Icon(CupertinoIcons.shuffle,
                  color: audioPlayer.shuffleModeEnabled
                      ? Colors.deepOrange
                      : Colors.white),
              iconSize: 20,
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              tooltip: songData.audioPlayer.currentIndex! > 0
                  ? songData.currentPlaylist[songData.currentIndex - 1].title
                  : 'This is the first song of the playlist',
              onPressed: () {
                songData.prev();
                // songData.generateColors();
              },
              icon: const Icon(CupertinoIcons.backward_end_fill,
                  color: Colors.white),
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
                  child: const CircularProgressIndicator(color: Colors.white),
                );
              } else if (!audioPlayer.playing) {
                return IconButton(
                  color: Colors.white,
                  iconSize: 70,
                  onPressed: () {
                    if (songData.currentSong == 'Click to play' &&
                        audioPlayer.position == Duration.zero) {
                      songData.audioPlayer.setAudioSource(
                        songData.initializePlaylist(songData.songs),
                        initialIndex: songData.currentIndex,
                      );
                      songData.setCurrentSong(songData.currentIndex);
                    }
                    audioPlayer.play();
                    songData.isPlaying = true;
                  },
                  icon: const Icon(
                    CupertinoIcons.play_circle_fill,
                  ),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  color: Colors.white,
                  iconSize: 70,
                  onPressed: () {
                    audioPlayer.pause();
                    songData.isPlaying = false;
                  },
                  icon: const Icon(
                    CupertinoIcons.pause_circle_fill,
                  ),
                );
              } else if (processingState == ProcessingState.completed) {
                return IconButton(
                  color: Colors.white,
                  iconSize: 70,
                  onPressed: () {
                    audioPlayer.pause();
                    songData.isPlaying = false;
                  },
                  icon: const Icon(
                    CupertinoIcons.pause_circle_fill,
                  ),
                );
              } else {
                return IconButton(
                  color: Colors.white,
                  iconSize: 75,
                  onPressed: () {
                    audioPlayer.seek(
                      Duration.zero,
                      index: audioPlayer.effectiveIndices!.first,
                    );
                    songData.isPlaying = false;
                  },
                  icon: const Icon(
                    CupertinoIcons.memories,
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              tooltip: songData.audioPlayer.currentIndex! <
                      songData.currentPlaylist.length - 1
                  ? songData.currentPlaylist[songData.currentIndex + 1].title
                  : 'End of the playlist',
              onPressed: () {
                songData.next();
                // songData.generateColors();
              },
              icon: const Icon(CupertinoIcons.forward_end_fill,
                  color: Colors.white),
              iconSize: 30,
            );
          },
        ),
        StreamBuilder<LoopMode>(
          stream: audioPlayer.loopModeStream,
          builder: (context, snapshot) {
            final loopMode = snapshot.data;
            if (loopMode == LoopMode.one) {
              return IconButton(
                tooltip: 'Looping to This SONG only',
                onPressed: () {
                  showToast(context, 'Loop mode ALL');
                  audioPlayer.setLoopMode(LoopMode.all);
                },
                icon: const Icon(
                  Icons.refresh,
                ),
                color: Colors.deepOrange,
                iconSize: 20,
              );
            } else if (loopMode == LoopMode.all) {
              return IconButton(
                tooltip: 'Looping to ALL SONGS',
                onPressed: () {
                  showToast(context, 'Loop mode OFF');
                  audioPlayer.setLoopMode(LoopMode.off);
                },
                icon: const Icon(
                  Icons.loop_outlined,
                ),
                color: Colors.deepOrange,
                iconSize: 20,
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
              color: Colors.white,
              iconSize: 20,
            );
          },
        ),
      ],
    );
  }
}
