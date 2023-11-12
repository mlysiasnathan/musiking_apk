import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import './screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  void requestStoragePermission() async {
    // only if platform is not web, coz web have no permission
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      // ensure build method is called
      setState(() {});
    }
  }

  @override
  void initState() {
    requestStoragePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColorLight = Theme.of(context).primaryColorLight;
    final songData = Provider.of<SongsLocal>(context, listen: false);
    final playlistData = Provider.of<Playlists>(context, listen: false);
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: primaryColorLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 50),
            Container(
              // margin: const EdgeInsets.only(bottom: 10.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 70.0),
              transform: Matrix4.rotationZ(-14 * pi / 180)..translate(-0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                'MusiKing',
                style: TextStyle(
                  fontSize: 35,
                  color: primaryColorLight,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 19,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/musiccovers/musiking_logo.jpg',
                  width: mediaQuery.height * 0.20,
                  height: mediaQuery.height * 0.20,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FutureBuilder<List<AlbumModel>>(
              //default values
              future: _audioQuery.queryAlbums(
                  sortType: null,
                  ignoreCase: true,
                  uriType: UriType.EXTERNAL,
                  orderType: OrderType.ASC_OR_SMALLER),
              builder: (context, item) {
                //loading content indicator
                if (item.data == null) {
                  return const SizedBox();
                }
                // no album found
                if (item.data!.isEmpty) {
                  return const SizedBox();
                }

                playlistData.playlists.clear();
                playlistData.playlists = item.data!;
                return const SizedBox();
              },
            ),
            Column(
              children: [
                const Text(
                  'From',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 4.0,
                  ),
                ),
                Image.asset(
                  'assets/musiccovers/lysnB_land_logo_png.png',
                  width: mediaQuery.width * 0.3,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(color: primaryColorLight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
