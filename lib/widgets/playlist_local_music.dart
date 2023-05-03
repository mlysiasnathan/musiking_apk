import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';
import './section_header.dart';
import './song_card_local.dart';

class LocalPlaylistMusic extends StatelessWidget {
  const LocalPlaylistMusic({
    Key? key,
    required OnAudioQuery audioQuery,
  })  : _audioQuery = audioQuery,
        super(key: key);

  final OnAudioQuery _audioQuery;

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context, listen: false);
    // return FutureBuilder<List<SongModel>>(
    //   //default values
    //   future: _audioQuery.querySongs(
    //       sortType: null,
    //       ignoreCase: true,
    //       uriType: UriType.EXTERNAL,
    //       orderType: OrderType.ASC_OR_SMALLER),
    //   builder: (context, item) {
    //     //loading content indicator
    //     if (item.data == null) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     // no songs found
    //     if (item.data!.isEmpty) {
    //       return const Center(
    //         child: Text(
    //           'No songs found in this device',
    //           style: TextStyle(fontSize: 19),
    //         ),
    //       );
    //     }
    //     if (!songData.pageLoaded) {
    //       songData.songs.clear();
    //       songData.songs = item.data!;
    //       songData.pageLoaded = true;
    //     }
    return Padding(
      padding: const EdgeInsets.all(19),
      child: Column(
        children: [
          SectionHeader(
            title: 'Local Songs',
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
    //   },
    // );
  }
}
