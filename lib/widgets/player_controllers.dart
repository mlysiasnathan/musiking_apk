import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerControllers extends StatelessWidget {
  const PlayerControllers({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed:
                  audioPlayer.shuffleModeEnabled ? audioPlayer.shuffle : null,
              icon: Icon(CupertinoIcons.shuffle,
                  color: audioPlayer.shuffleModeEnabled
                      ? Colors.white
                      : Colors.grey),
              iconSize: 20,
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed:
                  audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
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
                  child: const CircularProgressIndicator(),
                );
              } else if (!audioPlayer.playing) {
                return IconButton(
                  color: Colors.white,
                  iconSize: 75,
                  onPressed: audioPlayer.play,
                  icon: const Icon(
                    CupertinoIcons.play_circle_fill,
                  ),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  color: Colors.white,
                  iconSize: 75,
                  onPressed: audioPlayer.pause,
                  icon: const Icon(
                    CupertinoIcons.pause_circle_fill,
                  ),
                );
              } else {
                return IconButton(
                  color: Colors.white,
                  iconSize: 75,
                  onPressed: () => audioPlayer.seek(
                    Duration.zero,
                    index: audioPlayer.effectiveIndices!.first,
                  ),
                  icon: const Icon(
                    CupertinoIcons.memories,
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null,
              icon: const Icon(CupertinoIcons.forward_end_fill,
                  color: Colors.white),
              iconSize: 30,
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              child: IconButton(
                onPressed: () {
                  return;
                },
                icon: const Icon(
                  Icons.loop_outlined,
                ),
                color: Colors.white,
                iconSize: 20,
              ),
            );
          },
        ),
      ],
    );
  }
}
