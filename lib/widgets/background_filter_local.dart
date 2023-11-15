import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColorDark = Theme.of(context).primaryColorDark;
    final songData = Provider.of<SongsLocal>(context, listen: false);
    // final paletteGenerator = songData.paletteGenerator;

    return Container(
      decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: Image.memory(
          //     QueryArtworkWidget(
          //       id: songData.songs[songData.currentIndex].id,
          //       type: ArtworkType.AUDIO,
          //     ) as Uint8List,
          //   ).image,
          //   fit: BoxFit.cover,
          // ),
          ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 48, sigmaY: 28),
        child: Container(
          decoration: BoxDecoration(
            color: primaryColorDark.withOpacity(0.3),
            // paletteGenerator != null
            //     ? paletteGenerator.vibrantColor != null
            //         ? paletteGenerator.vibrantColor!.color.withOpacity(0.7)
            //         : Colors.black.withOpacity(0.7)
            //     : Colors.black.withOpacity(0.7),
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

// other way

// class _BackgroundFilter extends StatefulWidget {
//   const _BackgroundFilter({
//     Key? key,
//     required this.image,
//   }) : super(key: key);
//   final QueryArtworkWidget image;
//
//   @override
//   State<_BackgroundFilter> createState() => _BackgroundFilterState();
// }
//
// class _BackgroundFilterState extends State<_BackgroundFilter> {
//   // final audioQuery = OnAudioQuery();
//   // someName() async {
//   //   // DEFAULT: ArtworkFormat.JPEG, 200 and false
//   //   return await audioQuery.queryArtwork(
//   //     1,
//   //     ArtworkType.AUDIO,
//   //   );
//   // }
//
//   // PaletteGenerator? paletteGenerator;
//   // Color defaultLightColor = Colors.orange;
//   // Color defaultDarkColor = Colors.deepOrange;
//   // Future<PaletteGenerator?> generateColors() async {
//   //   paletteGenerator = await PaletteGenerator.fromImageProvider(
//   //     // someName(),
//   //     Image.asset(
//   //       QueryArtworkWidget(
//   //         id: widget.image.id,
//   //         type: ArtworkType.AUDIO,
//   //       ).toString(),
//   //     ).image,
//   //     // size: const Size.square(1000),
//   //     region: const Rect.fromLTRB(0, 0, 1000, 1000),
//   //   );
//   //   setState(() {});
//   //   return paletteGenerator;
//   // }
//   //
//   // @override
//   // void initState() {
//   //   generateColors();
//   //   super.initState();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: Image.asset(
//             QueryArtworkWidget(
//               id: widget.image.id,
//               type: ArtworkType.AUDIO,
//             ).toString(),
//           ).image,
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: BackdropFilter(
//         filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.7),
//             // paletteGenerator != null
//             //     ? paletteGenerator!.dominantColor != null
//             //         ? paletteGenerator!.dominantColor!.color
//             //             .withOpacity(0.7)
//             //         : Colors.black.withOpacity(0.7)
//             //     : Colors.black.withOpacity(0.7),
//           ),
//         ),
//       ),
//     );
//
//     // android UI========================
//
//     // return ShaderMask(
//     //   shaderCallback: (item) {
//     //     return LinearGradient(
//     //       begin: Alignment.topCenter,
//     //       end: Alignment.bottomCenter,
//     //       colors: [
//     //         Colors.black,
//     //         Colors.black.withOpacity(0.6),
//     //         Colors.black.withOpacity(0.0),
//     //       ],
//     //       stops: const [
//     //         0.0,
//     //         0.6,
//     //         0.9,
//     //       ],
//     //     ).createShader(item);
//     //   },
//     //   blendMode: BlendMode.dstOut,
//     //   child: Container(
//     //     decoration: BoxDecoration(
//     //       gradient: LinearGradient(
//     //         begin: Alignment.topCenter,
//     //         end: Alignment.bottomCenter,
//     //         colors: [
//     //           paletteGenerator != null
//     //               ? paletteGenerator!.vibrantColor != null
//     //                   ? paletteGenerator!.vibrantColor!.color
//     //                   : defaultLightColor
//     //               : defaultLightColor,
//     //           paletteGenerator != null
//     //               ? paletteGenerator!.dominantColor != null
//     //                   ? paletteGenerator!.dominantColor!.color
//     //                   : defaultDarkColor
//     //               : defaultDarkColor,
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     // );
