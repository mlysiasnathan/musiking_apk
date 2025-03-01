import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musiking/routes/on_boarding_screen.dart';
import 'package:provider/provider.dart';
import './helpers/constant.dart';
import './routes/refresh_screen.dart';
import './routes/song_screen.dart';

import './routes/screens.dart';
import './models/models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider()..getIn(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Songs(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Playlists(),
        ),
      ],
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        // home: const SplashScreen(),

        home: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, splashSnapshot) =>
          splashSnapshot.connectionState == ConnectionState.waiting
              ? const SplashScreen()
              : themeProvider.isFirstTime
              ? const OnBoardingScreen()
              :  FutureBuilder(
              future:  Provider.of<Songs>(
                  context,
                  listen: false,
                ).setSongs(),
              builder: (context, snapshots) =>
              snapshots.connectionState == ConnectionState.waiting &&
                  !Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).isInit
                  ? const SplashScreen()
                  : const CustomBottomTab(),
            ),
        ),
        routes: {
          SplashScreen.routeName: (ctx) => const SplashScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          AlbumScreen.routeName: (ctx) => const AlbumScreen(),
          SongScreen.routeName: (ctx) => const SongScreen(),
          RefreshScreen.routeName: (ctx) => const RefreshScreen(),
          FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
          EqualizerScreen.routeName: (ctx) => const EqualizerScreen(),
          CustomBottomTab.routeName: (ctx) => const CustomBottomTab(),
        },
      ),
    );
  }
}

