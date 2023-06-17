import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
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
    final playlistData = Provider.of<Playlists>(context);
    final OnAudioQuery _audioQuery = OnAudioQuery();
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        top: 5,
        bottom: 5,
      ),
      child:
          // FutureBuilder<List<AlbumModel>>(
          //   //default values
          //   future: _audioQuery.queryAlbums(
          //       sortType: null,
          //       ignoreCase: true,
          //       uriType: UriType.EXTERNAL,
          //       orderType: OrderType.ASC_OR_SMALLER),
          //   builder: (context, item) {
          //     //loading content indicator
          //     if (item.data == null) {
          //       return const Center(
          //         child: CircularProgressIndicator(color: Colors.white),
          //       );
          //     }
          //     // no album found
          //     if (item.data!.isEmpty) {
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: const [
          //           Icon(
          //             Icons.do_not_disturb_alt,
          //             size: 55,
          //           ),
          //           Text(
          //             'Albums Not Found probably Musics list is Empty',
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 16,
          //             ),
          //           ),
          //         ],
          //       );
          //     }
          //     playlistData.playlists.clear();
          //     playlistData.playlists = item.data!;
          //     return Column(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(right: 14),
          //           child: SectionHeader(
          //             title: "Albums",
          //             action: () => playlistData.viewMoreAlbum(),
          //           ),
          //         ),
          //         const SizedBox(height: 10),
          //         SizedBox(
          //           height: playlistData.isViewMoreAlbum
          //               ? playlistData.playlists.length > 9
          //                   ? mediaQuery.size.height * 0.47
          //                   : playlistData.playlists.length <= 3
          //                       ? mediaQuery.size.height * 0.17
          //                       : mediaQuery.size.height *
          //                           ((0.17 * (playlistData.playlists.length / 3)) +
          //                               0.13)
          //               : mediaQuery.size.height * 0.25,
          //           child: playlistData.isViewMoreAlbum
          //               ? GridView.builder(
          //                   physics: playlistData.playlists.length > 9
          //                       ? null
          //                       : const NeverScrollableScrollPhysics(),
          //                   gridDelegate:
          //                       const SliverGridDelegateWithFixedCrossAxisCount(
          //                     crossAxisCount: 3,
          //                     mainAxisSpacing: 10,
          //                     crossAxisSpacing: 1,
          //                   ),
          //                   itemCount: playlistData.playlists.length,
          //                   itemBuilder: (context, index) {
          //                     return AlbumCard(
          //                         playlist: playlistData.playlists[index]);
          //                   },
          //                 )
          //               : ListView.builder(
          //                   scrollDirection: Axis.horizontal,
          //                   itemCount: playlistData.playlists.length >= 6
          //                       ? 6
          //                       : playlistData.playlists.length,
          //                   itemBuilder: (context, index) {
          //                     return AlbumCard(
          //                         playlist: playlistData.playlists[index]);
          //                   },
          //                 ),
          //         )
          //       ],
          //     );
          //   },
          // ),
          playlistData.playlists.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.do_not_disturb_alt,
                      size: 55,
                    ),
                    Text(
                      'Albums Not Found probably Musics list is Empty',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              : Column(
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
                                      ((0.17 *
                                              (playlistData.playlists.length /
                                                  3)) +
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
                                return AlbumCard(
                                    playlist: playlistData.playlists[index]);
                              },
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: playlistData.playlists.length >= 6
                                  ? 6
                                  : playlistData.playlists.length,
                              itemBuilder: (context, index) {
                                return AlbumCard(
                                    playlist: playlistData.playlists[index]);
                              },
                            ),
                    )
                  ],
                ),
    );
  }
}
