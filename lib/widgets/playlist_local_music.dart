import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
    return FutureBuilder<List<SongModel>>(
      //default values
      future: _audioQuery.querySongs(
          sortType: null,
          ignoreCase: true,
          uriType: UriType.EXTERNAL,
          orderType: OrderType.ASC_OR_SMALLER),
      builder: (context, item) {
        //loading content indicator
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // no songs found
        if (item.data!.isEmpty) {
          return const Center(
            child: Text('No songs found in this device'),
          );
        }
        //show songs
        return Padding(
          padding: const EdgeInsets.all(19),
          child: Column(
            children: [
              const SectionHeader(title: 'Local Songs'),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 14),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: item.data!.length,
                itemBuilder: ((context, index) {
                  return SongCardLocal(song: item.data![index]);
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
