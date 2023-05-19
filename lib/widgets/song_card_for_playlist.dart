import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class SongCardForPlaylist extends StatelessWidget {
  const SongCardForPlaylist(
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
    final songData = Provider.of<SongsLocal>(context, listen: false);
    return InkWell(
      onTap: () async {
        songData.currentPlaylist = songs;
        await songData.audioPlayer.setAudioSource(
          songData.initializePlaylist(songs),
          initialIndex: index,
        );
        await songData.audioPlayer.play();
        songData.isPlaying = true;
        songData.setCurrentSong(index);
        songData.generateColors();
      },
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        minLeadingWidth: 1,
        leading: Consumer<SongsLocal>(builder: (ctx, songData, _) {
          if (song.title == songData.currentSong) {
            return const Icon(Icons.play_arrow, color: Colors.white, size: 30);
          } else {
            return Text(
              '${index + 1}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            );
          }
        }),
        title: Text(
          song.title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${song.album} - ${_formatDuration(song.duration as int)}',
          style: Theme.of(context).textTheme.labelSmall!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
