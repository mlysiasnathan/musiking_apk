import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musiking/routes/equalizer_screen.dart';
import 'package:musiking/routes/favorites_screen.dart';
import 'package:musiking/routes/song_screen_local.dart';
import 'package:provider/provider.dart';

import './routes/playlist_screen.dart';
import './routes/song_screen.dart';
import './routes/home_screen.dart';
import './models/playlists_provider.dart';
import './models/songs_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Songs(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Playlists(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MusiKing',
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
        home: const HomeScreen(),
        getPages: [
          GetPage(
            name: '/',
            page: () => const HomeScreen(),
          ),
          GetPage(
            name: '/song',
            page: () => const SongScreen(),
          ),
          GetPage(
            name: '/songLocal',
            page: () => const SongScreenLocal(),
          ),
          GetPage(
            name: '/playlist',
            page: () => const PlaylistScreen(),
          ),
          GetPage(
            name: '/favorites',
            page: () => const Favorites(),
          ),
          GetPage(
            name: '/equalizer',
            page: () => const Equalizer(),
          )
        ],
      ),
    );
  }
}
