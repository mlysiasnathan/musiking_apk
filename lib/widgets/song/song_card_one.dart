import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    this.showIndex = false,
    required this.playLists,
  }) : super(key: key);
  final List<SongModel> playLists;
  final SongModel song;
  final int index;
  final bool showBigSize;
  final bool showIndex;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final songData = Provider.of<Songs>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    Future<void> onTap() async {
      await songData.audioPlayer
          .setAudioSource(
            songData.initializePlaylist(playLists),
            initialIndex: index,
          )
          .then((_) async => await songData.audioPlayer.play());
      if (songData.currentPlaylist != playLists) {
        songData.currentPlaylist = playLists;
        songData.saveCurrentPlayList();
      }
      songData.saveCurrentSong(song);
    }

    return showBigSize
        ? Container(
            margin: const EdgeInsets.only(top: 8),
            key: ValueKey(song.id),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.primaryColor,
            ),
            child: ListTile(
              onTap: onTap,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 0,
              ),
              splashColor: theme.primaryColorDark,
              leading: QueryArtworkWidget(
                id: song.id,
                type: ArtworkType.AUDIO,
                artworkWidth: deviceSize.width * 0.15,
                artworkHeight: deviceSize.width * 0.16,
                artworkFit: BoxFit.cover,
                artworkBorder: BorderRadius.circular(8),
                nullArtworkWidget: Container(
                  width: deviceSize.width * 0.16,
                  height: deviceSize.width * 0.16,
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
            onTap: onTap,
            key: ValueKey(song.id),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: deviceSize.width * 0.14,
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (showIndex)
                    Container(
                      width: deviceSize.width * 0.12,
                      height: deviceSize.width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: theme.colorScheme.background.withOpacity(0.7),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    )
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: QueryArtworkWidget(
                        id: song.id,
                        type: ArtworkType.AUDIO,
                        artworkWidth: deviceSize.width * 0.12,
                        artworkHeight: deviceSize.width * 0.12,
                        artworkBorder: BorderRadius.zero,
                        nullArtworkWidget: ClipRRect(
                          child: Container(
                            width: deviceSize.width * 0.12,
                            height: deviceSize.width * 0.12,
                            color:
                                theme.colorScheme.background.withOpacity(0.7),
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
          );
  }
}

class SongCardLoading extends StatelessWidget {
  const SongCardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.primaryColor,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 0,
        ),
        splashColor: theme.primaryColorDark,
        leading: Container(
          width: deviceSize.width * 0.15,
          height: deviceSize.width * 0.16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: theme.colorScheme.background.withOpacity(0.6),
          ),
          child: Icon(
            Icons.music_note,
            color: theme.primaryColor,
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 2000.ms),
        title: Container(
          width: 80,
          height: 17,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: theme.colorScheme.background,
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 3000.ms),
        subtitle: Container(
          width: 50,
          height: 14,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: theme.colorScheme.background.withOpacity(0.5),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1000.ms),
        trailing: Container(
          width: 30,
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: theme.colorScheme.background.withOpacity(0.5),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 2000.ms),
      ),
    );
  }
}
