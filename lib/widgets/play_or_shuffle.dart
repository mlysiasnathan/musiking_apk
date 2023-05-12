import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';

class PlayOrShuffleSwitch extends StatelessWidget {
  const PlayOrShuffleSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.7;
    final songData = Provider.of<SongsLocal>(context);
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
            showToast(
                context,
                songData.audioPlayer.shuffleModeEnabled
                    ? 'Shuffle mode Enabled'
                    : 'Shuffle mode Disabled');
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
