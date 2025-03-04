import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../helpers/constant.dart';
import '../../models/models.dart';
import '../../routes/screens.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final AlbumModel playlist;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final playlistData = Provider.of<Playlists>(context);
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        key: ValueKey(playlist.id),
        onTap: () => Navigator.of(context)
            .pushNamed(AlbumScreen.routeName, arguments: playlist),
        borderRadius: playlistData.isViewMoreAlbum
            ? BorderRadius.circular(15)
            : BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: deviceSize.width * 0.43,
              height: deviceSize.width * 0.43,
              child: Hero(
                tag: playlist.id,
                child: QueryArtworkWidget(
                  id: playlist.id,
                  artworkBorder: playlistData.isViewMoreAlbum
                      ? BorderRadius.circular(15)
                      : BorderRadius.circular(20),
                  type: ArtworkType.ALBUM,
                  keepOldArtwork: true,
                  nullArtworkWidget: Container(
                    width: deviceSize.width * 0.43,
                    height: deviceSize.width * 0.43,
                    decoration: BoxDecoration(
                      borderRadius: playlistData.isViewMoreAlbum
                          ? BorderRadius.circular(15)
                          : BorderRadius.circular(20),
                      color: theme.colorScheme.background.withOpacity(0.6),
                    ),
                    child: Icon(
                      Icons.album,
                      size: playlistData.isViewMoreAlbum ? 100 : 150,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: playlistData.isViewMoreAlbum
                  ? deviceSize.height * 0.05
                  : deviceSize.height * 0.07,
              width: playlistData.isViewMoreAlbum
                  ? deviceSize.width * 0.27
                  : deviceSize.width * 0.37,
              margin: EdgeInsets.only(
                  bottom: playlistData.isViewMoreAlbum ? 4 : 10),
              decoration: BoxDecoration(
                borderRadius: playlistData.isViewMoreAlbum
                    ? BorderRadius.circular(10)
                    : BorderRadius.circular(15),
                color: theme.colorScheme.background.withOpacity(0.75),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: deviceSize.width * 0.25,
                        child: Text(
                          playlist.album,
                          style: playlistData.isViewMoreAlbum
                              ? theme.textTheme.labelSmall
                              : theme.textTheme.titleMedium!
                                  .copyWith(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${playlist.numOfSongs} song${playlist.numOfSongs <= 1 ? '' : 's'}',
                        style: theme.textTheme.labelSmall!.copyWith(
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
                      color: theme.primaryColorDark,
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
