import 'package:flutter/material.dart';

import './section_header.dart';
import './song_card.dart';
import '../models/song_model.dart';

class PlaylistMusic extends StatelessWidget {
  const PlaylistMusic({
    Key? key,
    required this.songs,
  }) : super(key: key);

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19),
      child: Column(
        children: [
          SectionHeader(title: 'All Songs', action: () => null),
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
