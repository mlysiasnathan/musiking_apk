import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../helpers/constant.dart';

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
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: theme.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 18.0,
                horizontal: 70.0,
              ),
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
                appName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.primaryColor,
                  fontSize: 35,
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
                  imageList[0],
                  width: deviceSize.height * 0.20,
                  height: deviceSize.height * 0.20,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'From',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.background,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Image.asset(
                  imageList[1],
                  width: deviceSize.width * 0.35,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  color: theme.primaryColor,
                  backgroundColor: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(30),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
