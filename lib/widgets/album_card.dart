import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/playlists_provider_local.dart';
import '../routes/playlist_screen.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final AlbumModel playlist;

  @override
  Widget build(BuildContext context) {
    final playlistData = Provider.of<Playlists>(context);
    final mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PlaylistScreen.routeName, arguments: playlist);
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: mediaQuery.width * 0.43,
              height: mediaQuery.height * 0.43,
              // decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(15),
              //   image: DecorationImage(
              //     image: Image.asset(
              //       QueryArtworkWidget(
              //         id: playlist.id,
              //         type: ArtworkType.ALBUM,
              //       ).toString(),
              //     ).image,
              //     fit: BoxFit.cover,
              //   ),
              //   // AssetImage(
              //   //     playlist.album,
              //   //   ),
              //   //   fit: BoxFit.cover,
              //   //   ),
              // ),
              child: QueryArtworkWidget(
                id: playlist.id,
                artworkBorder: BorderRadius.circular(15),
                type: ArtworkType.ALBUM,
                nullArtworkWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.white.withOpacity(0.7),
                    child: const FlutterLogo(
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: playlistData.isViewMoreAlbum ? 40 : 50,
              width: playlistData.isViewMoreAlbum
                  ? mediaQuery.width * 0.27
                  : mediaQuery.width * 0.35,
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
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${playlist.numOfSongs} songs',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.blueGrey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  if (!playlistData.isViewMoreAlbum)
                    const Icon(
                      Icons.play_circle,
                      color: Colors.red,
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
