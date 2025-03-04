import 'package:flutter/material.dart';
import 'package:musiking/widgets/album/album_card_loading.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../routes/refresh_screen.dart';
import '../widgets.dart';

class AlbumsArea extends StatelessWidget {
  const AlbumsArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final playlistData = Provider.of<Playlists>(context, listen: true);
    const int viewMoreLength = 3;
    const int viewLessLength = 6;
    return playlistData.playlists.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14, top: 5, right: 14),
                child: SectionHeader(
                  title: "No Albums found",
                  action: () =>
                      Navigator.pushNamed(context, RefreshScreen.routeName),
                  actionText: 'Refresh',
                  afterActionText: 'Refreshed',
                ),
              ),
              SizedBox(height: deviceSize.height * 0.04),
              Icon(
                Icons.do_not_disturb_alt,
                color: theme.primaryColorLight,
                size: 50,
              ),
              SizedBox(height: deviceSize.height * 0.02),
              Text(
                'Albums Not Found',
                style: theme.textTheme.titleMedium!.copyWith(
                  color: theme.colorScheme.background,
                ),
              ),
              SizedBox(height: deviceSize.height * 0.08),
            ],
          )
        : Consumer<Playlists>(
            builder: (ctx, playlistData, _) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    bottom: 8,
                  ),
                  child: SectionHeader(
                    title:
                        "${playlistData.playlists.length} Album${playlistData.playlists.length <= 1 ? '' : 's'}",
                    action: playlistData.viewMoreAlbum,
                    showButton: playlistData.playlists.length > viewLessLength,
                  ),
                ),
                SizedBox(
                  height: playlistData.isViewMoreAlbum
                      ? deviceSize.width *
                          (0.4 *
                              (playlistData.playlists.length / viewMoreLength)
                                  .ceil())
                      : deviceSize.width * 0.43,
                  child: playlistData.isViewMoreAlbum
                      ? GridView.builder(
                          shrinkWrap: true,
                          addRepaintBoundaries: true,
                          addAutomaticKeepAlives: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: viewMoreLength,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 1,
                          ),
                          itemCount: playlistData.playlists.length,
                          itemBuilder: (context, index) {
                            return AlbumCard(
                              playlist: playlistData.playlists[index],
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          addRepaintBoundaries: true,
                          addAutomaticKeepAlives: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              playlistData.playlists.length < viewLessLength
                                  ?playlistData.playlists.length
                                  : viewLessLength,
                          itemBuilder: (context, index) {
                            return AlbumCard(
                              key: ValueKey(
                                playlistData.playlists[index].id,
                              ),
                              playlist: playlistData.playlists[index],
                            );
                          },
                        ),
                )
              ],
            ),
          );

    //   FutureBuilder(
    //   future: playlistData.setAlbumsList(),
    //   builder: (context, snapshots) => snapshots.connectionState ==
    //           ConnectionState.waiting
    //       ? Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.only(left: 14, top: 5, right: 14),
    //               child: SectionHeader(
    //                 title: 'Loading...',
    //                 action: () {},
    //                 actionText: 'Wait',
    //                 afterActionText: 'Wait',
    //               ),
    //             ),
    //             SizedBox(
    //               height: deviceSize.height * 0.20,
    //               child: ListView.builder(
    //                 shrinkWrap: true,
    //                 addRepaintBoundaries: true,
    //                 addAutomaticKeepAlives: true,
    //                 scrollDirection: Axis.horizontal,
    //                 itemCount: 3,
    //                 itemBuilder: (context, index) => const AlbumCardLoading(),
    //               ),
    //             ),
    //           ],
    //         )
    //       : playlistData.playlists.isEmpty
    //           ? Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Padding(
    //                   padding:
    //                       const EdgeInsets.only(left: 14, top: 5, right: 14),
    //                   child: SectionHeader(
    //                     title: "No Albums found",
    //                     action: () => playlistData.setAlbumsList(),
    //                     actionText: 'Refresh',
    //                     afterActionText: 'Refreshed',
    //                   ),
    //                 ),
    //                 SizedBox(height: deviceSize.height * 0.04),
    //                 CircleAvatar(
    //                   backgroundColor: theme.colorScheme.background,
    //                   child: Icon(
    //                     Icons.do_not_disturb_alt,
    //                     color: theme.primaryColorLight,
    //                   ),
    //                 ),
    //                 SizedBox(height: deviceSize.height * 0.02),
    //                 Text(
    //                   'Albums Not Found probably Musics list is Empty',
    //                   style: theme.textTheme.titleMedium!.copyWith(
    //                     color: theme.colorScheme.background,
    //                   ),
    //                 ),
    //                 SizedBox(height: deviceSize.height * 0.08),
    //               ],
    //             )
    //           : Consumer<Playlists>(
    //               builder: (ctx, playlistData, _) => Column(
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(
    //                       left: 14,
    //                       right: 14,
    //                       bottom: 8,
    //                     ),
    //                     child: SectionHeader(
    //                       title:
    //                           "${playlistData.playlists.length} Album${playlistData.playlists.length <= 1 ? '' : 's'}",
    //                       action: playlistData.viewMoreAlbum,
    //                       showButton:
    //                           playlistData.playlists.length > viewLessLength,
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: playlistData.isViewMoreAlbum
    //                         ? deviceSize.width *
    //                             (0.4 *
    //                                 (playlistData.playlists.length /
    //                                         viewMoreLength)
    //                                     .ceil())
    //                         : deviceSize.width * 0.43,
    //                     child: playlistData.isViewMoreAlbum
    //                         ? GridView.builder(
    //                             shrinkWrap: true,
    //                             addRepaintBoundaries: true,
    //                             addAutomaticKeepAlives: true,
    //                             physics: const NeverScrollableScrollPhysics(),
    //                             gridDelegate:
    //                                 const SliverGridDelegateWithFixedCrossAxisCount(
    //                               crossAxisCount: viewMoreLength,
    //                               mainAxisSpacing: 5,
    //                               crossAxisSpacing: 1,
    //                             ),
    //                             itemCount: playlistData.playlists.length,
    //                             itemBuilder: (context, index) {
    //                               return AlbumCard(
    //                                 playlist: playlistData.playlists[index],
    //                               );
    //                             },
    //                           )
    //                         : ListView.builder(
    //                             shrinkWrap: true,
    //                             addRepaintBoundaries: true,
    //                             addAutomaticKeepAlives: true,
    //                             scrollDirection: Axis.horizontal,
    //                             itemCount: playlistData.playlists.length >=
    //                                     viewLessLength
    //                                 ? viewLessLength
    //                                 : playlistData.playlists.length,
    //                             itemBuilder: (context, index) {
    //                               return AlbumCard(
    //                                 key: ValueKey(
    //                                   playlistData.playlists[index].id,
    //                                 ),
    //                                 playlist: playlistData.playlists[index],
    //                               );
    //                             },
    //                           ),
    //                   )
    //                 ],
    //               ),
    //             ),
    // );
  }
}
