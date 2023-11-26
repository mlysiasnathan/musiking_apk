import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
    final ThemeData theme = Theme.of(context);
    final Color primaryColorLight = theme.primaryColorLight;
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: primaryColorLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 50),
            Container(
              // margin: const EdgeInsets.only(bottom: 10.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 70.0),
              transform: Matrix4.rotationZ(-14 * pi / 180)..translate(-0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: theme.colorScheme.background,
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
            Column(
              children: [
                const Text(
                  'From',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    // color: theme.colorScheme.background,
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
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
