import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../providers/songs_provider.dart';
import '../widgets/song/background_filter.dart';
import '../widgets/song/music_ui.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});
  static const routeName = '/song-screen';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Consumer<Songs>(
            builder: (ctx, songData, child) => QueryArtworkWidget(
              id: songData.currentSong!.id,
              type: ArtworkType.AUDIO,
              artworkFit: BoxFit.cover,
              artworkHeight: double.infinity,
              artworkWidth: double.infinity,
              artworkBorder: BorderRadius.zero,
              keepOldArtwork: true,
              nullArtworkWidget: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.colorScheme.shadow.withOpacity(0.6),
                ),
                child: Icon(
                  Icons.music_note,
                  color: theme.primaryColor,
                  size: 300,
                ),
              ),
            ),
          ),
          const BackgroundFilter(),
          const MusicUi(),
        ],
      ),
      endDrawer: Consumer<Songs>(
        builder: (ctx, songData, child) => Drawer(
          // width: 0.9,
          backgroundColor: theme.colorScheme.background.withOpacity(0.8),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewInsets.top + 30,
              right: 10,
              left: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: songData.autoScroll,
                  child: Text(
                    'Playlist of ${songData.currentPlaylist.length} song${songData.currentPlaylist.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      color: theme.primaryColorLight,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
                Divider(color: theme.primaryColorLight),
                Expanded(
                  child: ListView.builder(
                    controller: songData.scrollCtrl,
                    itemCount: songData.currentPlaylist.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          songData.audioPlayer.setAudioSource(
                            songData
                                .initializePlaylist(songData.currentPlaylist),
                            initialIndex: index,
                          );
                          songData.audioPlayer.play();
                          songData.setCurrentSong(index);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Consumer<Songs>(
                          builder: (ctx, songData, _) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: songData.currentPlaylist[index] ==
                                      songData.currentSong
                                  ? theme.primaryColorLight
                                  : null,
                            ),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(width: 4),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: QueryArtworkWidget(
                                    id: songData.currentPlaylist[index].id,
                                    type: ArtworkType.AUDIO,
                                    artworkBorder: BorderRadius.zero,
                                    artworkWidth: 42,
                                    artworkHeight: 42,
                                    nullArtworkWidget: Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: theme.colorScheme.background
                                            .withOpacity(0.6),
                                      ),
                                      child: Icon(
                                        Icons.music_note,
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    '${songData.currentPlaylist.indexOf(songData.currentPlaylist[index]) + 1} - \t${songData.currentPlaylist[index].title}',
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      color: songData.currentPlaylist[index] ==
                                              songData.currentSong
                                          ? null
                                          : theme.primaryColorLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  splashRadius: 23,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_horiz_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
