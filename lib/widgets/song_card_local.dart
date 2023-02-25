import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

// import '../models/song_model.dart';

class SongCardLocal extends StatelessWidget {
  const SongCardLocal({
    Key? key,
    required this.song,
  }) : super(key: key);

  final SongModel song;
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
    return InkWell(
      onTap: () {
        Get.toNamed('/songLocal', arguments: song);
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.7),
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
                artworkHeight: 40,
                artworkWidth: 40,
                artworkBorder: BorderRadius.zero,
                nullArtworkWidget: const Icon(Icons.music_note_outlined),
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${song.artist} - ${_formatDuration(song.duration as int)}',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
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
