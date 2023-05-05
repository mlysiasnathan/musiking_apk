import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/playlists_provider_local.dart';
import '../models/songs_provider_local.dart';
import './custom_tab_screen_bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
    final songData = Provider.of<SongsLocal>(context, listen: false);
    final playlistData = Provider.of<Playlists>(context, listen: false);
    // void _loadingMusics() async {
    //   if (songData.songs.isEmpty) {
    //     await Navigator.pushReplacementNamed(context, '/home');
    //   }
    // }

    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 50),
            Container(
              // margin: const EdgeInsets.only(bottom: 10.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80.0),
              transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
              // ..translate(-10.0),
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
              child: const Text(
                'MusiKing',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
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
            FutureBuilder<List<SongModel>>(
              //default values
              future: _audioQuery.querySongs(
                  sortType: null,
                  ignoreCase: true,
                  uriType: UriType.EXTERNAL,
                  orderType: OrderType.ASC_OR_SMALLER),
              builder: (context, item) {
                //loading content indicator
                if (item.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // no songs found
                if (item.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'No songs found in this device',
                          style: TextStyle(fontSize: 19),
                        ),
                        TextButton(
                          child: const Text('Try again'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  );
                }
                songData.songs.clear();
                songData.songs = item.data!;
                // _loadingMusics();
                return TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, CustomTabScreenBottomBar.routeName);
                  },
                  child: const Text('Skip'),
                );
              },
            ),
            const Text(
              'LOADING Songs.....',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
