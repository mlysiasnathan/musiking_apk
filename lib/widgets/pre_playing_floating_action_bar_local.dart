import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';
import '../routes/song_local_bottom_sheet.dart';

class PrePlayingSong extends StatelessWidget {
  const PrePlayingSong({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context, listen: false);
    void songBottomSheet(BuildContext ctx) {
      showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return const Scaffold(
            body: FractionallySizedBox(
              heightFactor: 1.0,
              child: SongBottomSheet(),
            ),
          );
        },
      );
    }

    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null ? songData.setCurrentSong(index) : null;
    });

    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.94,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: InkWell(
              onTap: () {
                songData.paletteGenerator == null
                    ? songData.generateColors()
                    : null;
                songBottomSheet(context);
              },
              borderRadius: BorderRadius.circular(5),
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Consumer<SongsLocal>(
                      builder: (ctx, songData, _) => QueryArtworkWidget(
                        id: songData.currentPlaylist.isEmpty
                            ? 0
                            : songData
                                .currentPlaylist[songData.currentIndex].id,
                        type: ArtworkType.AUDIO,
                        artworkBorder: BorderRadius.zero,
                        artworkHeight: 42,
                        artworkWidth: 42,
                        nullArtworkWidget: ClipRRect(
                          child: Container(
                            color: Colors.deepOrange,
                            child: Image.asset(
                              color: Colors.white,
                              'assets/musiccovers/musiking_logo.png',
                              width: 42,
                              height: 42,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Consumer<SongsLocal>(
                    builder: (ctx, songData, _) => Text(
                      songData.currentSong,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            splashRadius: 40,
            splashColor: Colors.deepOrange,
            onPressed: () async {
              if (songData.currentSong == 'Click to play') {
                await songData.audioPlayer.setAudioSource(
                  songData.initializePlaylist(songData.currentPlaylist),
                  initialIndex: songData.currentIndex,
                );
                await songData.audioPlayer.play();
                songData.setCurrentSong(songData.currentIndex);
                songData.generateColors();
              } else {
                songData
                    .playPause(songData.currentPlaylist[songData.currentIndex]);
              }
            },
            icon: Consumer<SongsLocal>(
              builder: (ctx, songData, _) => Icon(
                songData.isPlaying
                    ? CupertinoIcons.pause_circle
                    : CupertinoIcons.play_circle,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
