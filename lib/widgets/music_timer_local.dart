import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:musiking/models/songs_provider_local.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../widgets/seekbar.dart';
import '../widgets/music_controllers_local.dart';

class MusicTimer extends StatelessWidget {
  const MusicTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    final seekBarDataStream = songData.seekBarDataStream;
    final audioPlayer = songData.audioPlayer;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 50),
      // padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                label: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Consumer<SongsLocal>(
                builder: (ctx, songData, _) => QueryArtworkWidget(
                  id: songData.songs[songData.currentIndex].id,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.zero,
                  artworkHeight: mediaQuery.size.height * 0.45,
                  artworkWidth: mediaQuery.size.height * 0.45,
                  artworkFit: BoxFit.cover,
                  nullArtworkWidget: const Icon(
                    CupertinoIcons.music_note_2,
                    size: 55,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Consumer<SongsLocal>(
            builder: (ctx, songData, _) => Text(
              songData.songs[songData.currentIndex].title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Consumer<SongsLocal>(
            builder: (ctx, songData, _) => Text(
              songData.songs[songData.currentIndex].artist.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          StreamBuilder<SeekBarData>(
            stream: seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return Consumer<SongsLocal>(
                builder: (ctx, songData, _) => SeekBar(
                  position: positionData?.position ?? Duration.zero,
                  duration: positionData?.duration ?? Duration.zero,
                  onChangedEnd: audioPlayer.seek,
                ),
              );
            },
          ),
          const MusicControllers(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PopupMenuButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black.withOpacity(0.8),
                icon: const Icon(
                  CupertinoIcons.info_circle,
                  color: Colors.white,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: ListTile(
                        leading:
                            const Icon(Icons.music_note, color: Colors.white),
                        title: Consumer<SongsLocal>(
                          builder: (ctx, songData, _) => Text(
                              songData.songs[songData.currentIndex].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.album, color: Colors.white),
                        title: Consumer<SongsLocal>(
                          builder: (ctx, songData, _) => Text(
                              songData.songs[songData.currentIndex].album
                                  .toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading:
                            const Icon(Icons.folder_open, color: Colors.white),
                        title: Consumer<SongsLocal>(
                          builder: (ctx, songData, _) => Text(
                              songData.songs[songData.currentIndex].uri
                                  .toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true),
                        ),
                      ),
                    ),
                  ];
                },
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      backgroundColor: Colors.black.withOpacity(0.8),
                      elevation: 0,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text(
                        'Playlist and Queue',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: songData.songs.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                songData.setCurrentSong(index);
                                songData.generateColors();
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Consumer<SongsLocal>(
                                builder: (ctx, songData, _) => Container(
                                  color: index == songData.currentIndex
                                      ? Colors.deepOrange
                                      : null,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: QueryArtworkWidget(
                                          id: songData
                                              .songs[songData.currentIndex].id,
                                          type: ArtworkType.AUDIO,
                                          artworkBorder: BorderRadius.zero,
                                          artworkWidth: 40,
                                          artworkHeight: 40,
                                          nullArtworkWidget: const Icon(
                                              CupertinoIcons.music_note_2),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              songData.songs[index].title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${songData.songs.indexOf(songData.songs[index]) + 1}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            const Divider(
                                              color: Colors.white,
                                              height: 1,
                                            )
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        splashRadius: 23,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.more_horiz_outlined,
                                          color: Colors.white,
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
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  CupertinoIcons.square_list,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
