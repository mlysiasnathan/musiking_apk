import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:musiking/helpers/custom_route_animation.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../routes/screens.dart';

class PrePlayingSong extends StatelessWidget {
  const PrePlayingSong({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageStorageBucket bucket = PageStorageBucket();
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
              child: SongBottomSheet(key: PageStorageKey<String>('song')),
            ),
          );
        },
      );
    }

    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null ? songData.setCurrentSong(index) : null;
    });

    return PageStorage(
      bucket: bucket,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.94,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                songData.paletteGenerator == null
                    ? songData.generateColors()
                    : null;
                songBottomSheet(context);
                // Navigator.of(context).push(
                //   PageRouteBuilder(
                //     pageBuilder: (context, animation, secondAnimation) =>
                //         const SongPlayerScreen(),
                //     transitionDuration: const Duration(milliseconds: 1000),
                //     transitionsBuilder:
                //         (context, animation, secondAnimation, child) =>
                //             SlideTransition(
                //       position: animation.drive(
                //         Tween(begin: const Offset(0.0, 0.1), end: Offset.zero)
                //             .chain(
                //           CurveTween(
                //             curve: Curves.ease,
                //           ),
                //         ),
                //       ),
                //       child: child,
                //     ),
                //   ),
                // );
              },
              key: ValueKey(songData.currentPlaylist[songData.currentIndex].id),
              borderRadius: BorderRadius.circular(5),
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Consumer<SongsLocal>(
                      builder: (ctx, songData, _) =>
                          //   Hero(
                          // tag: songData.currentPlaylist[songData.currentIndex].id,
                          // child:
                          QueryArtworkWidget(
                        keepOldArtwork: true,
                        id: songData.currentPlaylist[songData.currentIndex].id,
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
                  // ),
                  const SizedBox(width: 18),
                  Consumer<SongsLocal>(
                    builder: (ctx, songData, _) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: Text(
                        songData.currentSong,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              splashRadius: 40,
              splashColor: Colors.deepOrange,
              onPressed: () async {
                if (songData.currentSong == 'Click to play' ||
                    songData.audioPlayer.currentIndex == null) {
                  songData.currentPlaylist = songData.songs;
                  await songData.audioPlayer.setAudioSource(
                    songData.initializePlaylist(songData.currentPlaylist),
                    initialIndex: songData.currentIndex,
                  );
                  songData.generateColors();
                  await songData.audioPlayer.play();
                  songData.isPlaying = true;
                  songData.setCurrentSong(songData.currentIndex);
                } else {
                  songData.playPause(
                      songData.currentPlaylist[songData.currentIndex]);
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
      ),
    );
  }
}
