import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/playlists_provider_local.dart';
import './album_card.dart';
import './section_header.dart';

class AlbumMusic extends StatelessWidget {
  const AlbumMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final playlistData = Provider.of<Playlists>(context);
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
              action: () => playlistData.viewMoreAlbum(),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: playlistData.isViewMoreAlbum
                ? playlistData.playlists.length > 9
                    ? mediaQuery.size.height * 0.47
                    : playlistData.playlists.length <= 3
                        ? mediaQuery.size.height * 0.17
                        : mediaQuery.size.height *
                            ((0.17 * (playlistData.playlists.length / 3)) +
                                0.13)
                : mediaQuery.size.height * 0.25,
            child: playlistData.isViewMoreAlbum
                ? GridView.builder(
                    physics: playlistData.playlists.length > 9
                        ? null
                        : const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: playlistData.playlists.length,
                    itemBuilder: (context, index) {
                      return AlbumCard(playlist: playlistData.playlists[index]);
                    },
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: playlistData.playlists.length >= 6
                        ? 6
                        : playlistData.playlists.length,
                    itemBuilder: (context, index) {
                      return AlbumCard(playlist: playlistData.playlists[index]);
                    },
                  ),
          )
        ],
      ),
    );
  }
}
