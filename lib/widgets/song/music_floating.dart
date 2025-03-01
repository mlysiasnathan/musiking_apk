import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'package:musiking/routes/song_screen.dart';
import '../../models/models.dart';
import '../../routes/screens.dart';

class MusicFloating extends StatelessWidget {
  const MusicFloating({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
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
                          color: theme.primaryColorLight,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Divider(color: theme.primaryColorLight),
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
                                  color: songData.currentPlaylist[index] ==
                                          songData.currentSong
                                      ? theme.primaryColorLight
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
                                              color: theme.primaryColorLight,
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
                                          color:
                                              songData.currentPlaylist[index] ==
                                                      songData.currentSong
                                                  ? null
                                                  : theme.primaryColorLight,
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
              onTap: () => Navigator.pushNamed(context, SongScreen.routeName),
              onDoubleTap: () => songBottomSheet(context),
              borderRadius: BorderRadius.circular(5),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: FutureBuilder(
                      future: Future.delayed(Durations.long1),
                      builder: (context, snapshots) =>
                          snapshots.connectionState == ConnectionState.waiting
                              ? Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: theme.colorScheme.background
                                        .withOpacity(0.6),
                                  ),
                                  child: Icon(
                                    Icons.music_note,
                                    color: theme.primaryColor,
                                  ),
                                )
                              : Consumer<Songs>(
                                  builder: (ctx, songData, _) =>
                                      QueryArtworkWidget(
                                    keepOldArtwork: true,
                                    id: songData.currentSong?.id ?? 0,
                                    type: ArtworkType.AUDIO,
                                    artworkBorder: BorderRadius.zero,
                                    artworkHeight: 42,
                                    artworkWidth: 42,
                                    nullArtworkWidget: Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: theme.primaryColor,
                                      ),
                                      child: Icon(
                                        Icons.music_note,
                                        color: theme.colorScheme.background,
                                      ),
                                    ),
                                  ),
                                ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Consumer<Songs>(
                    builder: (ctx, songData, _) => SizedBox(
                      width: deviceSize.width * 0.60,
                      child: Text(
                        songData.currentSong?.title ?? '',
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.primaryColor,
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
                          color: theme.primaryColor,
                        ),
                      ),
                    );
                  } else if (!songData.audioPlayer.playing) {
                    return IconButton(
                      splashRadius: 40,
                      splashColor: theme.primaryColor,
                      onPressed: () async {
                        if (songData.currentSong == null ||
                            songData.audioPlayer.currentIndex == null) {
                          songData.currentPlaylist = songData.songs;
                          await songData.audioPlayer.setAudioSource(
                            songData
                                .initializePlaylist(songData.currentPlaylist),
                            initialIndex: 0,
                          );
                          songData.setCurrentSong(0);
                        }
                        audioPlayer.play();
                      },
                      icon: Icon(
                        color: theme.primaryColor,
                        CupertinoIcons.play_circle,
                      ),
                    );
                  } else if (snapshot.data!.processingState !=
                      ProcessingState.completed) {
                    return IconButton(
                      splashRadius: 40,
                      splashColor: theme.primaryColor,
                      onPressed: audioPlayer.pause,
                      icon: Icon(
                        color: theme.primaryColor,
                        CupertinoIcons.pause_circle,
                      ),
                    );
                  } else if (snapshot.data!.processingState ==
                      ProcessingState.completed) {
                    return IconButton(
                      splashRadius: 40,
                      splashColor: theme.primaryColor,
                      onPressed: audioPlayer.pause,
                      icon: Icon(
                        color: theme.primaryColor,
                        CupertinoIcons.pause_circle,
                      ),
                    );
                  } else {
                    return IconButton(
                      splashRadius: 40,
                      splashColor: theme.primaryColor,
                      onPressed: () => audioPlayer.seek(
                        Duration.zero,
                        index: audioPlayer.effectiveIndices!.first,
                      ),
                      icon: Icon(
                        CupertinoIcons.memories,
                        color: theme.primaryColor,
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
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
