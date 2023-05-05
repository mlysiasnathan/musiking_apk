import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider.dart';
import './section_header.dart';
import './song_card.dart';
import '../models/song_model.dart';

class PlaylistMusic extends StatelessWidget {
  const PlaylistMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Song> songs = Provider.of<Songs>(context).songs;
    return Padding(
      padding: const EdgeInsets.all(19),
      child: Column(
        children: [
          SectionHeader(title: 'Assets Songs', action: () => null),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 14),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songs.length,
            itemBuilder: ((context, index) {
              return SongCard(song: songs[index]);
            }),
          ),
        ],
      ),
    );
  }
}
