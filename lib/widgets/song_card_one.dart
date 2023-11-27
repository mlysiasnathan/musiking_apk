import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class SongCardOne extends StatelessWidget {
  const SongCardOne({
    Key? key,
    required this.song,
    required this.index,
  }) : super(key: key);

  final SongModel song;
  final int index;

  String _formatDuration(int? dur) {
    final duration = Duration(milliseconds: dur!.toInt());
    if (duration == null) {
      return '00:00';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColorLight = theme.primaryColorLight;
    final songData = Provider.of<Songs>(context, listen: false);

    return InkWell(
      onTap: () async {
        songData.currentPlaylist = songData.songs;
        await songData.audioPlayer.setAudioSource(
          songData.initializePlaylist(songData.songs),
          initialIndex: index,
        );
        await songData.audioPlayer.play();
        songData.setCurrentSong(index);
      },
      key: ValueKey(song.id),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
          color: primaryColorLight.withOpacity(0.7),
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
                    color: theme.colorScheme.background.withOpacity(0.7),
                    child: Image.asset(
                      color: primaryColorLight,
                      'assets/musiccovers/musiking_logo.png',
                      width: 43,
                      height: 43,
                      fit: BoxFit.cover,
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
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.background,
                    ),
                  ),
                  Text(
                    '${song.artist == '<unknown>' ? 'Unknown Artist' : song.artist} - ${_formatDuration(song.duration!)}',
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
