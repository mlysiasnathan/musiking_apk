import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/playlist_model.dart';
import '../models/songs_provider.dart';
import './album_card.dart';
import './section_header.dart';

class AlbumMusic extends StatelessWidget {
  const AlbumMusic({
    Key? key,
    required this.playlists,
  }) : super(key: key);

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<Songs>(context);
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        top: 5,
        bottom: 5,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: SectionHeader(
              title: "Albums",
              action: () => songData.viewMoreAlbum(),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: songData.isViewMoreAlbum
                ? playlists.length > 9
                    ? mediaQuery.size.height * 0.47
                    : playlists.length <= 3
                        ? mediaQuery.size.height * 0.17
                        : mediaQuery.size.height *
                            ((0.17 * (playlists.length / 3)) + 0.13)
                : mediaQuery.size.height * 0.25,
            child: songData.isViewMoreAlbum
                ? GridView.builder(
                    physics: playlists.length > 9
                        ? null
                        : const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      return AlbumCard(playlist: playlists[index]);
                    },
                  )
                : ListView.builder(
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
