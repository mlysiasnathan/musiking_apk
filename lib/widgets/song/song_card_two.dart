import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';

class SongCardTwo extends StatelessWidget {
  const SongCardTwo(
      {Key? key, required this.song, required this.index, required this.songs})
      : super(key: key);
  final SongModel song;
  final List<SongModel> songs;
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
    final songData = Provider.of<Songs>(context, listen: false);
    return InkWell(
      onTap: () async {
        songData.currentPlaylist = songs;
        await songData.audioPlayer.setAudioSource(
          songData.initializePlaylist(songData.currentPlaylist),
          initialIndex: index,
        );
        await songData.audioPlayer.play();
        songData.setCurrentSong(index);
      },
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        minLeadingWidth: 1,
        leading: Consumer<Songs>(builder: (ctx, songData, _) {
          if (song.title == songData.currentSong) {
            return Icon(Icons.play_arrow,
                color: theme.colorScheme.background, size: 30);
          } else {
            return Text(
              '${index + 1}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.background),
            );
          }
        }),
        title: Text(
          song.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold, color: theme.colorScheme.background),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${song.album} - ${_formatDuration(song.duration as int)}',
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: theme.colorScheme.background),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: theme.colorScheme.background,
          ),
        ),
      ),
    );
  }
}
