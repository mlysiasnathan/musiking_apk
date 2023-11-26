import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class SongPlayerScreen extends StatefulWidget {
  const SongPlayerScreen({super.key});
  static const routeName = '/songScreen-local';

  @override
  State<SongPlayerScreen> createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final songData = Provider.of<SongsLocal>(context, listen: false);
    songData.audioPlayer.currentIndexStream.listen((index) {
      index != null ? songData.setCurrentSong(index) : null;
    });
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          Stack(children: [
            Consumer<SongsLocal>(
              builder: (ctx, songData, child) => QueryArtworkWidget(
                id: songData.songs[songData.currentIndex].id,
                type: ArtworkType.AUDIO,
                artworkFit: BoxFit.cover,
                artworkHeight: double.infinity,
                artworkWidth: double.infinity,
                artworkBorder: BorderRadius.zero,
                keepOldArtwork: true,
                nullArtworkWidget: ClipRRect(
                  child: Image.asset(
                    'assets/musiccovers/musiking_logo.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            const BackgroundFilter(),
            const MusicTimer(),
          ])
        ],
      ),
    );
    // );
  }
}
