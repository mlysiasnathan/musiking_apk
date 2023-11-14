import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import './widgets.dart';

class AlbumMusic extends StatelessWidget {
  const AlbumMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final Color primaryColorLight = Theme.of(context).primaryColorLight;

    final playlistData = Provider.of<Playlists>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 5),
      child: FutureBuilder(
        future: playlistData.setAlbumsList(),
        builder: (context, snapshots) => snapshots.connectionState ==
                ConnectionState.waiting
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SectionHeader(
                    title: 'Loading...',
                    action: () {},
                    actionText: 'Wait',
                    afterActionText: 'Wait',
                  ),
                  LinearProgressIndicator(color: primaryColorLight),
                  SizedBox(height: mediaQuery.size.height * 0.2),
                ],
              )
            : playlistData.playlists.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SectionHeader(
                        title: "No Albums found",
                        action: () => playlistData.setAlbumsList(),
                        actionText: 'Refresh',
                        afterActionText: 'Refreshed',
                      ),
                      SizedBox(height: mediaQuery.size.height * 0.04),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.do_not_disturb_alt,
                          color: primaryColorLight,
                        ),
                      ),
                      SizedBox(height: mediaQuery.size.height * 0.02),
                      const Text(
                        'Albums Not Found probably Musics list is Empty',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: mediaQuery.size.height * 0.08),
                    ],
                  )
                : Consumer<Playlists>(
                    builder: (ctx, playlistData, _) => Column(
                      children: [
                        SectionHeader(
                          title: "Albums (${playlistData.playlists.length})",
                          action: () => playlistData.viewMoreAlbum(),
                        ),
                        // SizedBox(height: mediaQuery.size.height * 0.015),
                        SizedBox(
                          height: playlistData.isViewMoreAlbum
                              ? playlistData.playlists.length > 9
                                  ? mediaQuery.size.height * 0.47
                                  : playlistData.playlists.length <= 3
                                      ? mediaQuery.size.height * 0.25
                                      : mediaQuery.size.height *
                                          ((0.17 *
                                                  (playlistData
                                                          .playlists.length /
                                                      3)) +
                                              0.13)
                              : mediaQuery.size.height * 0.22,
                          child: playlistData.isViewMoreAlbum
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  addRepaintBoundaries: true,
                                  addAutomaticKeepAlives: true,
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
                                    return AlbumCard(
                                        playlist:
                                            playlistData.playlists[index]);
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  addRepaintBoundaries: true,
                                  addAutomaticKeepAlives: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: playlistData.playlists.length >= 6
                                      ? 6
                                      : playlistData.playlists.length,
                                  itemBuilder: (context, index) {
                                    return AlbumCard(
                                        key: ValueKey(
                                            playlistData.playlists[index].id),
                                        playlist:
                                            playlistData.playlists[index]);
                                  },
                                ),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
