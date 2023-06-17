import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class SongCardLocal extends StatelessWidget {
  const SongCardLocal({
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
    final songData = Provider.of<SongsLocal>(context, listen: false);
    var _isLoading = true;
    Future<void> showPicture() async {
      try {
        QueryArtworkWidget(
          id: song.id,
          type: ArtworkType.AUDIO,
          artworkHeight: 43,
          artworkWidth: 43,
          artworkBorder: BorderRadius.zero,
          nullArtworkWidget: ClipRRect(
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child: Image.asset(
                color: Colors.deepOrange,
                'assets/musiccovers/musiking_logo.png',
                width: 43,
                height: 43,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
        _isLoading = false;
      } catch (error) {
        print('error here : $error');
        _isLoading = true;
        rethrow;
      }
    }

    showPicture();
    return InkWell(
      onTap: () async {
        songData.currentPlaylist = songData.songs;
        await songData.audioPlayer.setAudioSource(
          songData.initializePlaylist(songData.songs),
          initialIndex: index,
        );
        await songData.audioPlayer.play();
        songData.isPlaying = true;
        songData.setCurrentSong(index);
        songData.generateColors();
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: _isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : QueryArtworkWidget(
                      id: song.id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: 43,
                      artworkWidth: 43,
                      artworkBorder: BorderRadius.zero,
                      nullArtworkWidget: ClipRRect(
                        child: Container(
                          color: Colors.white.withOpacity(0.7),
                          child: Image.asset(
                            color: Colors.deepOrange,
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${song.artist == '<unknown>' ? 'Unknown Artist' : song.artist} - ${_formatDuration(song.duration!)}',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            Consumer<SongsLocal>(
              builder: (ctx, songData, _) => Icon(
                  song.title == songData.currentSong ? Icons.play_arrow : null,
                  color: Colors.white,
                  size: 16),
            ),
            IconButton(
              splashRadius: 23,
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
