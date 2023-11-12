import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../routes/screens.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final AlbumModel playlist;

  @override
  Widget build(BuildContext context) {
    final Color primaryColorLight = Theme.of(context).primaryColorLight;
    final Color primaryColorDark = Theme.of(context).primaryColorDark;
    final playlistData = Provider.of<Playlists>(context);
    final mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PlaylistScreen.routeName, arguments: playlist);
      },
      key: ValueKey(playlist.id),
      borderRadius: playlistData.isViewMoreAlbum
          ? BorderRadius.circular(15)
          : BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: mediaQuery.width * 0.43,
              height: mediaQuery.width * 0.43,
              child: Hero(
                tag: playlist.id,
                child: QueryArtworkWidget(
                  id: playlist.id,
                  artworkBorder: playlistData.isViewMoreAlbum
                      ? BorderRadius.circular(15)
                      : BorderRadius.circular(20),
                  type: ArtworkType.ALBUM,
                  keepOldArtwork: true,
                  nullArtworkWidget: ClipRRect(
                    borderRadius: playlistData.isViewMoreAlbum
                        ? BorderRadius.circular(15)
                        : BorderRadius.circular(20),
                    child: Container(
                      color: Colors.white.withOpacity(0.4),
                      child: Image.asset(
                        color: primaryColorLight,
                        'assets/musiccovers/musiking_logo.png',
                        width: mediaQuery.width * 0.43,
                        height: mediaQuery.height * 0.43,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: playlistData.isViewMoreAlbum
                  ? mediaQuery.height * 0.053
                  : mediaQuery.height * 0.073,
              width: playlistData.isViewMoreAlbum
                  ? mediaQuery.width * 0.27
                  : mediaQuery.width * 0.37,
              margin: EdgeInsets.only(
                  bottom: playlistData.isViewMoreAlbum ? 4 : 10),
              decoration: BoxDecoration(
                borderRadius: playlistData.isViewMoreAlbum
                    ? BorderRadius.circular(10)
                    : BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: mediaQuery.width * 0.25,
                        child: Text(
                          playlist.album,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: primaryColorDark,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        playlistData.isViewMoreAlbum ? 10 : 16,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${playlist.numOfSongs} songs',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.blueGrey,
                              fontSize: playlistData.isViewMoreAlbum ? 9 : 13,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  if (!playlistData.isViewMoreAlbum)
                    Icon(
                      Icons.play_circle,
                      color: primaryColorDark,
                    ),
                  if (!playlistData.isViewMoreAlbum) const SizedBox(width: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
