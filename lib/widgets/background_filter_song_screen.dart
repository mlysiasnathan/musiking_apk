import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider.dart';

class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<Songs>(context);
    final paletteGenerator = songData.paletteGenerator;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(songData.currentSong.coverUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: paletteGenerator != null
                ? paletteGenerator.dominantColor != null
                    ? paletteGenerator.dominantColor!.color.withOpacity(0.7)
                    : songData.defaultDarkColor
                : songData.defaultDarkColor,
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
    //         Colors.black.withOpacity(0.4),
    //         Colors.black.withOpacity(0.0),
    //       ],
    //       stops: const [
    //         0.0,
    //         0.2,
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
    //               ? paletteGenerator.vibrantColor != null
    //                   ? paletteGenerator.vibrantColor!.color
    //                   : songData.defaultLightColor
    //               : songData.defaultLightColor,
    //           paletteGenerator != null
    //               ? paletteGenerator.dominantColor != null
    //                   ? paletteGenerator.dominantColor!.color
    //                   : songData.defaultDarkColor
    //               : songData.defaultDarkColor,
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
