import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';
import './section_header.dart';
import './song_card_local.dart';

class LocalPlaylistMusic extends StatelessWidget {
  const LocalPlaylistMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(19),
      child: Column(
        children: [
          SectionHeader(
            title: 'All Songs',
            action: () => null, // songData.refreshSongList(),
            actionText: 'Refresh',
            afterActionText: 'Refresh',
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 14),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songData.songs.length,
            itemBuilder: ((context, index) {
              return SongCardLocal(song: songData.songs[index], index: index);
            }),
          ),
        ],
      ),
    );
  }
}
