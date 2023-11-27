import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../routes/screens.dart';

class MusicFloating extends StatelessWidget {
  const MusicFloating({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColorLight = theme.primaryColorLight;
    final PageStorageBucket bucket = PageStorageBucket();
    final songData = Provider.of<Songs>(context, listen: false);
    final audioPlayer = songData.audioPlayer;
    void songBottomSheet(BuildContext ctx) {
      showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return Scaffold(
            endDrawer: Drawer(
              // width: 0.9,
              backgroundColor: theme.colorScheme.background.withOpacity(0.8),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewInsets.top + 30,
                  right: 10,
                  left: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: songData.autoScroll,
                      child: Text(
                        'Playlist of ${songData.currentPlaylist.length} song${songData.currentPlaylist.length > 1 ? 's' : ''}',
                        style: TextStyle(
                          color: primaryColorLight,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Divider(color: primaryColorLight),
                    Expanded(
                      child: ListView.builder(
                        controller: songData.scrollCtrl,
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
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Consumer<Songs>(
                              builder: (ctx, songData, _) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: index == songData.currentIndex
                                      ? primaryColorLight
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
                                        id: songData.currentPlaylist[index].id,
                                        type: ArtworkType.AUDIO,
                                        artworkBorder: BorderRadius.zero,
                                        artworkWidth: 42,
                                        artworkHeight: 42,
                                        nullArtworkWidget: ClipRRect(
                                          child: Container(
                                            color: theme.colorScheme.background,
                                            child: Image.asset(
                                              color: primaryColorLight,
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
                                        '${songData.currentPlaylist.indexOf(songData.currentPlaylist[index]) + 1} - \t${songData.currentPlaylist[index].title}',
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: index == songData.currentIndex
                                              ? null
                                              : primaryColorLight,
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
                  ],
                ),
              ),
            ),
            body: const FractionallySizedBox(
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
          color: theme.colorScheme.background,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => songBottomSheet(context),
              borderRadius: BorderRadius.circular(5),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: FutureBuilder(
                      future: songData.getSongsList(),
                      builder: (context, snapshots) =>
                          snapshots.connectionState == ConnectionState.waiting
                              ? Container(
                                  color: primaryColorLight,
                                  child: Image.asset(
                                    color: theme.colorScheme.background,
                                    'assets/musiccovers/musiking_logo.png',
                                    width: 42,
                                    height: 42,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Consumer<Songs>(
                                  builder: (ctx, songData, _) =>
                                      QueryArtworkWidget(
                                    keepOldArtwork: true,
                                    id: songData
                                        .currentPlaylist[songData.currentIndex]
                                        .id,
                                    type: ArtworkType.AUDIO,
                                    artworkBorder: BorderRadius.zero,
                                    artworkHeight: 42,
                                    artworkWidth: 42,
                                    nullArtworkWidget: ClipRRect(
                                      child: Container(
                                        color: primaryColorLight,
                                        child: Image.asset(
                                          color: theme.colorScheme.background,
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
                  ),
                  const SizedBox(width: 18),
                  Consumer<Songs>(
                    builder: (ctx, songData, _) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: Text(
                        songData.currentSong,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primaryColorLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<PlayerState>(
              stream: songData.audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.processingState ==
                          ProcessingState.loading ||
                      snapshot.data!.processingState ==
                          ProcessingState.buffering) {
                    return Center(
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: primaryColorLight,
                        ),
                      ),
                    );
                  } else if (!songData.audioPlayer.playing) {
                    return IconButton(
                      splashRadius: 40,
                      splashColor: primaryColorLight,
                      onPressed: () async {
                        if (songData.currentSong == 'Click to play' ||
                            songData.audioPlayer.currentIndex == null) {
                          songData.currentPlaylist = songData.songs;
                          await songData.audioPlayer.setAudioSource(
                            songData
                                .initializePlaylist(songData.currentPlaylist),
                            initialIndex: songData.currentIndex,
                          );
                          songData.setCurrentSong(songData.currentIndex);
                        }
                        audioPlayer.play();
                      },
                      icon: Icon(
                        color: primaryColorLight,
                        CupertinoIcons.play_circle,
                      ),
                    );
                  } else if (snapshot.data!.processingState !=
                      ProcessingState.completed) {
                    return IconButton(
                      splashRadius: 40,
                      splashColor: primaryColorLight,
                      onPressed: audioPlayer.pause,
                      icon: Icon(
                        color: primaryColorLight,
                        CupertinoIcons.pause_circle,
                      ),
                    );
                  } else if (snapshot.data!.processingState ==
                      ProcessingState.completed) {
                    return IconButton(
                      splashRadius: 40,
                      splashColor: primaryColorLight,
                      onPressed: audioPlayer.pause,
                      icon: Icon(
                        color: primaryColorLight,
                        CupertinoIcons.pause_circle,
                      ),
                    );
                  } else {
                    return IconButton(
                      splashRadius: 40,
                      splashColor: primaryColorLight,
                      onPressed: () => audioPlayer.seek(
                        Duration.zero,
                        index: audioPlayer.effectiveIndices!.first,
                      ),
                      icon: Icon(
                        CupertinoIcons.memories,
                        color: primaryColorLight,
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: primaryColorLight,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
