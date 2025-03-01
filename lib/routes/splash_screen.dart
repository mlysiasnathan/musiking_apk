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
  // final OnAudioQuery _audioQuery = OnAudioQuery();
  //
  // void requestStoragePermission() async {
  //   // only if platform is not web, coz web have no permission
  //   if (!kIsWeb) {
  //     bool permissionStatus = await _audioQuery.permissionsStatus();
  //     if (!permissionStatus) {
  //       await _audioQuery.permissionsRequest();
  //     }
  //     // ensure build method is called
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    // requestStoragePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: deviceSize.width * 0.3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
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
                  width: deviceSize.height * 0.15,
                  height: deviceSize.height * 0.15,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Column(
              children: [
                Text(
                  'FROM',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  imageList[1],
                  width: deviceSize.width * 0.35,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  color:theme.colorScheme.background ,
                  minHeight: 1,
                  backgroundColor: theme.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
