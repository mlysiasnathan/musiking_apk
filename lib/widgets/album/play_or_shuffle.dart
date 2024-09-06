import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';

class PlayOrShuffleSwitch extends StatelessWidget {
  const PlayOrShuffleSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color primaryColor = theme.primaryColor;
    final Color primaryColorLight = theme.primaryColorLight;
    double width = MediaQuery.of(context).size.width * 0.7;
    final songData = Provider.of<Songs>(context);
    void showToast(BuildContext ctx, String message) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          content: Text(message, style: TextStyle(color: theme.primaryColor)),
        ),
      );
    }

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
                ? songData.audioPlayer
                    .setShuffleModeEnabled(false)
                    .then((_) => showToast(context, 'Shuffle mode Enabled'))
                : songData.audioPlayer
                    .setShuffleModeEnabled(true)
                    .then((_) => showToast(context, 'Shuffle mode Disabled'));
          },
          child: Container(
            height: 40,
            width: width,
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
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
                      color: primaryColorLight,
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
                                    ? theme.colorScheme.background
                                    : primaryColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.play_circle_outline,
                            color: !songData.audioPlayer.shuffleModeEnabled
                                ? theme.colorScheme.background
                                : primaryColor,
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
                                    ? primaryColor
                                    : theme.colorScheme.background,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            CupertinoIcons.shuffle,
                            color: !songData.audioPlayer.shuffleModeEnabled
                                ? primaryColor
                                : theme.colorScheme.background,
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
