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
    final ThemeData theme = Theme.of(context);
    final Color primaryColorLight = theme.primaryColorLight;

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
                  SizedBox(
                    height: mediaQuery.size.height * 0.22,
                    child: ListView.builder(
                      shrinkWrap: true,
                      addRepaintBoundaries: true,
                      addAutomaticKeepAlives: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: theme.colorScheme.background,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: SizedBox(
                            width: mediaQuery.size.width * 0.43,
                            height: mediaQuery.size.width * 0.43,
                          ),
                        );
                      },
                    ),
                  ),
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
                        backgroundColor: theme.colorScheme.background,
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
