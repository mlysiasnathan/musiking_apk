import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColorDark = Theme.of(context).primaryColorDark;

    return BackdropFilter(
      filter: ui.ImageFilter.blur(sigmaX: 48, sigmaY: 28),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColorDark.withOpacity(0.3),
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
    //         0.5,
    //         0.8,
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
    //                   ? paletteGenerator.vibrantColor!.color.withOpacity(0.7)
    //                   : primaryColorDark
    //               : primaryColorDark,
    //           paletteGenerator != null
    //               ? paletteGenerator.vibrantColor != null
    //                   ? paletteGenerator.vibrantColor!.color.withOpacity(0.7)
    //                   : primaryColorDark
    //               : primaryColorDark,
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
