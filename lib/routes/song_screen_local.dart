import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:rxdart/rxdart.dart' as rxdart;

// import '../models/song_model.dart';
import '../models/songs_provider.dart';
import '../widgets/seekbar.dart';
import '../widgets/player_controllers.dart';

class SongScreenLocal extends StatefulWidget {
  const SongScreenLocal({super.key});

  @override
  State<SongScreenLocal> createState() => _SongScreenLocalState();
}

class _SongScreenLocalState extends State<SongScreenLocal> {
  AudioPlayer audioPlayer = AudioPlayer();
  SongModel song = Get.arguments ?? Songs().songs[0];
  @override
  void initState() {
    super.initState();

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('${song.uri}'),
          ),
          AudioSource.uri(
            Uri.parse('asset:///${Songs().songs[4].musicUrl}'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream, audioPlayer.durationStream, (
        Duration position,
        Duration? duration,
      ) {
        return SeekBarData(
          position,
          duration ?? Duration.zero,
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(fit: StackFit.expand, children: [
        QueryArtworkWidget(
          id: song.id,
          type: ArtworkType.AUDIO,
        ),
        // Image.asset(
        //   song.coverUrl,
        //   fit: BoxFit.cover,
        // ),
        _BackgroundFilter(
          image: QueryArtworkWidget(
            id: song.id,
            type: ArtworkType.AUDIO,
          ),
        ),
        _MusicTimer(
            song: song,
            seekBarDataStream: _seekBarDataStream,
            audioPlayer: audioPlayer),
      ]),
    );
  }
}

class _MusicTimer extends StatelessWidget {
  const _MusicTimer({
    Key? key,
    required this.song,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
  })  : _seekBarDataStream = seekBarDataStream,
        super(key: key);
  final SongModel song;
  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            '${song.artist}',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 30),
          StreamBuilder<SeekBarData>(
            stream: _seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                position: positionData?.position ?? Duration.zero,
                duration: positionData?.duration ?? Duration.zero,
                onChangedEnd: audioPlayer.seek,
              );
            },
          ),
          PlayerControllers(audioPlayer: audioPlayer),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.gear_alt,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
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

class _BackgroundFilter extends StatefulWidget {
  const _BackgroundFilter({
    Key? key,
    required this.image,
  }) : super(key: key);
  final QueryArtworkWidget image;

  @override
  State<_BackgroundFilter> createState() => _BackgroundFilterState();
}

class _BackgroundFilterState extends State<_BackgroundFilter> {
  PaletteGenerator? paletteGenerator;
  Future<PaletteGenerator?> generateColors() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset(
        QueryArtworkWidget(
          id: widget.image.id,
          type: ArtworkType.AUDIO,
        ).toString(),
      ).image,
      size: const Size.square(1000),
      region: const Rect.fromLTRB(0, 0, 1000, 1000),
    );
    setState(() {});
    return paletteGenerator;
  }

  @override
  void initState() {
    generateColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (item) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.0),
          ],
          stops: const [
            0.0,
            0.3,
            0.9,
          ],
        ).createShader(item);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              paletteGenerator != null
                  ? paletteGenerator!.vibrantColor != null
                      ? paletteGenerator!.vibrantColor!.color
                      : Colors.orange
                  : Colors.orange,
              paletteGenerator != null
                  ? paletteGenerator!.darkVibrantColor != null
                      ? paletteGenerator!.darkVibrantColor!.color
                      : Colors.red
                  : Colors.red,
              // Colors.orange,
              // Colors.red,
            ],
          ),
        ),
      ),
    );
  }
}
