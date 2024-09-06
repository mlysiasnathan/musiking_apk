import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/playlists_provider_local.dart';
import '../providers/songs_provider.dart';
import '../widgets/section_header.dart';
import '../widgets/song/song_card_one.dart';

class RefreshScreen extends StatelessWidget {
  const RefreshScreen({super.key});
  static const routeName = '/refresh-screen';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final songData = Provider.of<Songs>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    final playlistData = Provider.of<Playlists>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Refresh songs list',
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.colorScheme.background,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: EdgeInsets.only(
            bottom: 10,
            right: 10,
            left: 10,
            top: deviceSize.height * 0.12,
          ),
          child: FutureBuilder(
            future: songData
                .getSongsList()
                .then((_) => playlistData.setAlbumsList()),
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
                            showButton: false,
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
                                title: 'No Songs found in this device',
                                action: () {},
                                actionText: 'Refresh',
                                afterActionText: 'Refreshed',
                                showButton: false,
                              ),
                              const SizedBox(height: 30),
                              Icon(
                                Icons.do_not_disturb_alt,
                                color: theme.primaryColorLight,
                                size: 90,
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                'Musics Not Found in every accessible folder',
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
                                  // showButton: false,
                                  title:
                                      '${playlistData.playlists.length} Album${playlistData.playlists.length <= 1 ? '' : 's'} found',
                                  action: () => songData.setSongs(),
                                  showButton: false,
                                ),
                                SectionHeader(
                                  // showButton: false,
                                  title:
                                      '${songData.songs.length} Music${songData.songs.length <= 1 ? '' : 's'} found',
                                  action: () => songData.setSongs(),
                                  showButton: false,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  addRepaintBoundaries: true,
                                  addAutomaticKeepAlives: true,
                                  padding: const EdgeInsets.all(0),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: songData.songs.length,
                                  itemBuilder: (context, index) => SongCardOne(
                                    key: ValueKey(index),
                                    song: songData.songs[index],
                                    index: songData.songs[index].id,
                                  ),
                                ),
                              ],
                            ),
                          ),
          ),
        ),
      ),
    );
  }
}
