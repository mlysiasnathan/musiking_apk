import 'package:flutter/material.dart';

import './album_card.dart';
import './section_header.dart';

import '../models/playlist_model.dart';

class AlbumMusic extends StatelessWidget {
  const AlbumMusic({
    Key? key,
    required this.playlists,
  }) : super(key: key);

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        top: 5,
        bottom: 5,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 14),
            child: SectionHeader(
              title: "Albums",
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            // height: MediaQuery.of(context).size.height * 0.45,
            height: MediaQuery.of(context).size.height * 0.25,
            child:
                // GridView.builder(
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 10,
                //     crossAxisSpacing: 1,
                //   ),
                //   itemCount: playlists.length,
                //   itemBuilder: (context, index) {
                //     return AlbumCard(playlist: playlists[index]);
                //   },
                // )
                ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playlists.length >= 6 ? 6 : playlists.length,
              itemBuilder: (context, index) {
                return AlbumCard(playlist: playlists[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
