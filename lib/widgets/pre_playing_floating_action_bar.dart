import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider.dart';
import '../routes/song_screen.dart';

class PrePlayingSong extends StatelessWidget {
  const PrePlayingSong({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<Songs>(context);

    return ChangeNotifierProvider(
      create: (c) => songData.currentSong,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SongScreen.routeName,
                      arguments: songData.currentSong);
                },
                borderRadius: BorderRadius.circular(5),
                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Hero(
                        tag: songData.currentSong.title,
                        child: Image.asset(
                          songData.currentSong.coverUrl,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Text(
                      songData.currentSong.title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              splashRadius: 40,
              splashColor: Colors.deepOrange,
              onPressed: () {
                songData.playPause(songData.currentSong);
              },
              icon: Icon(
                songData.isPlaying
                    ? CupertinoIcons.pause_circle
                    : CupertinoIcons.play_circle,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
