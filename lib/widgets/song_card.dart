import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song_model.dart';
import '../models/songs_provider.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    required this.song,
    Key? key,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Songs>(context, listen: false).clickToPlay(song);
      },
      borderRadius: BorderRadius.circular(10),
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
              child: Image.asset(
                song.coverUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    song.descriptions,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
            Icon(
                song == Provider.of<Songs>(context).currentSong
                    ? Icons.play_arrow
                    : null,
                color: Colors.white,
                size: 16),
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
