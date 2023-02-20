import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../models/song_model.dart';
import '../models/songs_provider.dart';
import '../widgets/seekbar.dart';
import '../widgets/player_controllers.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<Songs>(context);
    final audioPlayer = songData.audioPlayer;
    Song song = Get.arguments ?? songData.currentSong;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          song.coverUrl,
          fit: BoxFit.cover,
        ),
        _BackgroundFilter(
          image: song.coverUrl,
        ),
        _MusicTimer(
            song: song,
            seekBarDataStream: songData.seekBarDataStream,
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
  final Song song;
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
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Hero(
                tag: song.title,
                child: Image.asset(
                  song.coverUrl,
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.height * 0.45,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            song.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            song.descriptions,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
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
          const PlayerControllers(),
          const SizedBox(height: 10),
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
  final String image;

  @override
  State<_BackgroundFilter> createState() => _BackgroundFilterState();
}

class _BackgroundFilterState extends State<_BackgroundFilter> {
  PaletteGenerator? paletteGenerator;
  Color defaultLightColor = Colors.orange;
  Color defaultDarkColor = Colors.red;
  Future<PaletteGenerator?> generateColors() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset(widget.image).image,
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            widget.image,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color:
                // Colors.grey.shade200.withOpacity(0.5),
                paletteGenerator != null
                    ? paletteGenerator!.vibrantColor != null
                        ? paletteGenerator!.vibrantColor!.color.withOpacity(0.7)
                        : defaultDarkColor
                    : defaultDarkColor,
            // color: Colors.transparent,
          ),
        ),
      ),
    );

    // android UI========================

    // return ShaderMask(
    //   shaderCallback: (item) {
    //     return LinearGradient(
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //       colors: [
    //         Colors.black,
    //         Colors.black.withOpacity(0.5),
    //         Colors.black.withOpacity(0.0),
    //       ],
    //       stops: const [
    //         0.0,
    //         0.3,
    //         0.9,
    //       ],
    //     ).createShader(item);
    //   },
    //   blendMode: BlendMode.dstOut,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [
    //           paletteGenerator != null
    //               ? paletteGenerator!.vibrantColor != null
    //                   ? paletteGenerator!.vibrantColor!.color
    //                   : defaultLightColor
    //               : defaultLightColor,
    //           paletteGenerator != null
    //               ? paletteGenerator!.darkVibrantColor != null
    //                   ? paletteGenerator!.darkVibrantColor!.color
    //                   : defaultDarkColor
    //               : defaultDarkColor,
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
