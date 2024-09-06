import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../helpers/constant.dart';
import '../../models/models.dart';

class SongCardOne extends StatelessWidget {
  const SongCardOne({
    Key? key,
    required this.song,
    required this.index,
    this.showBigSize = false,
  }) : super(key: key);

  final SongModel song;
  final int index;
  final bool showBigSize;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final songData = Provider.of<Songs>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;

    return showBigSize
        ? Container(
            margin: const EdgeInsets.only(top: 8),
            key: ValueKey(song.id),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.primaryColor,
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 5.0,
              //     color: theme.colorScheme.shadow,
              //     offset: const Offset(0.0, 2.0),
              //   )
              // ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 2,
              ),
              splashColor: theme.primaryColorDark,
              onTap: () async {
                songData.currentPlaylist = songData.songs;
                await songData.audioPlayer.setAudioSource(
                  songData.initializePlaylist(songData.currentPlaylist),
                  initialIndex: index,
                );
                await songData.audioPlayer.play();
                songData.setCurrentSong(index);
              },
              leading: QueryArtworkWidget(
                id: song.id,
                type: ArtworkType.AUDIO,
                artworkWidth: deviceSize.width * 0.16,
                artworkHeight: deviceSize.width * 0.2,
                artworkFit: BoxFit.cover,
                artworkBorder: BorderRadius.circular(8),
                nullArtworkWidget: Container(
                  width: deviceSize.width * 0.16,
                  height: deviceSize.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.colorScheme.background.withOpacity(0.6),
                  ),
                  child: Icon(
                    Icons.music_note,
                    color: theme.primaryColor,
                  ),
                ),
              ),
              title: Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.background,
                ),
              ),
              subtitle: Text(
                '${song.artist == '<unknown>' ? 'Unknown Artist' : song.artist} - ${formatDuration(song.duration!)}',
                maxLines: 1,
                style: theme.textTheme.labelSmall!.copyWith(
                  color: theme.colorScheme.background,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: FittedBox(
                child: Row(
                  children: [
                    Consumer<Songs>(
                      builder: (ctx, songData, _) => Icon(
                          song.id == songData.currentSong?.id
                              ? Icons.play_circle_outline
                              : null,
                          color: theme.colorScheme.background,
                          size: 20),
                    ),
                    IconButton(
                      splashRadius: 23,
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz_outlined,
                        color: theme.colorScheme.background,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () async {
              songData.currentPlaylist = songData.songs;
              await songData.audioPlayer.setAudioSource(
                songData.initializePlaylist(songData.currentPlaylist),
                initialIndex: index,
              );
              print('playlist=================>>>>${songData.currentPlaylist}');
              // await songData.audioPlayer.play();
              songData.setCurrentSong(index);
            },
            key: ValueKey(song.id),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: QueryArtworkWidget(
                      id: song.id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: 43,
                      artworkWidth: 43,
                      artworkBorder: BorderRadius.zero,
                      nullArtworkWidget: ClipRRect(
                        child: Container(
                          width: 43,
                          height: 50,
                          color: theme.colorScheme.background.withOpacity(0.7),
                          child: Icon(
                            Icons.music_note,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          song.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.background,
                          ),
                        ),
                        Text(
                          '${song.artist == '<unknown>' ? 'Unknown Artist' : song.artist} - ${formatDuration(song.duration!)}',
                          maxLines: 1,
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: theme.colorScheme.background,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Consumer<Songs>(
                    builder: (ctx, songData, _) => Icon(
                        song.title == songData.currentSong
                            ? Icons.play_circle_outline
                            : null,
                        color: theme.colorScheme.background,
                        size: 20),
                  ),
                  IconButton(
                    splashRadius: 23,
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz_outlined,
                      color: theme.colorScheme.background,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
