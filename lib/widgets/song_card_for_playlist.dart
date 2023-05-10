import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';

class SongCardForPlaylist extends StatelessWidget {
  const SongCardForPlaylist(
      {Key? key, required this.song, required this.index, required this.songs})
      : super(key: key);
  final SongModel song;
  final List<SongModel> songs;
  final int index;
  String _formatDuration(int duration) {
    int h, m, s;
    h = duration ~/ 3600;
    m = ((duration - h * 3600)) ~/ 60;
    s = duration - (h * 3600) - (m * 60);

    // String hours = h.toString().length < 2 ? "0$h" : h.toString();
    String minutes = m.toString().length < 2 ? "0$m" : m.toString();
    String seconds = s.toString().length < 2 ? "0$s" : s.toString();

    return '$minutes:$seconds';
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
        songData.setCurrentSong(index);
        // songData.generateColors();
      },
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
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
        ),
        subtitle:
            Text('${song.album} - ${_formatDuration(song.duration as int)}'),
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
