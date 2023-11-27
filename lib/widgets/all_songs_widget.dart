import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import './widgets.dart';

class AllSongsWgt extends StatelessWidget {
  const AllSongsWgt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColorLight = theme.primaryColorLight;
    final songData = Provider.of<Songs>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(19),
      child:
          // songData.songs.isNotEmpty
          //     ? Consumer<Songs>(
          //         builder: (ctx, songData, _) => Column(
          //           children: [
          //             SectionHeader(
          //               title: 'All Songs (${songData.songs.length})',
          //               action: () => songData.setSongs(),
          //               actionText: 'Refresh',
          //               afterActionText: 'Refresh',
          //             ),
          //             ListView.builder(
          //               shrinkWrap: true,
          //               addRepaintBoundaries: true,
          //               addAutomaticKeepAlives: true,
          //               padding: const EdgeInsets.only(top: 4),
          //               physics: const NeverScrollableScrollPhysics(),
          //               itemCount: songData.songs.length,
          //               itemBuilder: ((context, index) {
          //                 return SongCardLocal(
          //                     key: ValueKey(index),
          //                     song: songData.songs[index],
          //                     index: index);
          //               }),
          //             ),
          //           ],
          //         ),
          //       )
          //     :
          FutureBuilder(
        future: songData.getSongsList(),
        builder: (context, snapshots) =>
            snapshots.connectionState == ConnectionState.waiting
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
                      ListView.builder(
                        shrinkWrap: true,
                        addRepaintBoundaries: true,
                        addAutomaticKeepAlives: true,
                        padding: const EdgeInsets.only(top: 4),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: ((context, index) {
                          return Container(
                            height: 50,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: theme.colorScheme.background,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }),
                      ),
                    ],
                  )
                : songData.songs.isEmpty && songData.isSongsSaved
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SectionHeader(
                            title: 'No Songs found',
                            action: () {},
                            actionText: 'Refresh',
                            afterActionText: 'Refreshed',
                          ),
                          const SizedBox(height: 30),
                          CircleAvatar(
                            backgroundColor: theme.colorScheme.background,
                            child: Icon(
                              Icons.do_not_disturb_alt,
                              color: primaryColorLight,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Musics Not Found probably Musics list is Empty',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    : Consumer<Songs>(
                        builder: (ctx, songData, _) => Column(
                          children: [
                            SectionHeader(
                              title: 'All Songs (${songData.songs.length})',
                              action: () => songData.setSongs(),
                              actionText: 'Refresh',
                              afterActionText: 'Refresh',
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              addRepaintBoundaries: true,
                              addAutomaticKeepAlives: true,
                              padding: const EdgeInsets.only(top: 4),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: songData.songs.length,
                              itemBuilder: ((context, index) {
                                return SongCardOne(
                                    key: ValueKey(index),
                                    song: songData.songs[index],
                                    index: index);
                              }),
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }
}
