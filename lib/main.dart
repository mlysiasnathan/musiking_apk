import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './routes/custom_tab_screen_bottom_bar.dart';
import './routes/equalizer_screen.dart';
import './routes/favorites_screen.dart';
import './routes/song_screen_local.dart';
import './routes/splash_screen.dart';
import './routes/playlist_screen.dart';
import './routes/song_screen.dart';
import './routes/home_screen.dart';
import './models/playlists_provider_local.dart';
import './models/songs_provider.dart';
import './models/songs_provider_local.dart';

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
          create: (ctx) => SongsLocal(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Playlists(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MusiKing',
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
        home: const SplashScreen(),
        routes: {
          CustomTabScreenBottomBar.routeName: (ctx) =>
              const CustomTabScreenBottomBar(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          SongScreen.routeName: (ctx) => const SongScreen(),
          SongScreenLocal.routeName: (ctx) => const SongScreenLocal(),
          PlaylistScreen.routeName: (ctx) => const PlaylistScreen(),
          FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
          EqualizerScreen.routeName: (ctx) => const EqualizerScreen(),
        },
      ),
    );
  }
}
