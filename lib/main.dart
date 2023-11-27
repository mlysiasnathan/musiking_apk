import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './routes/screens.dart';
import './models/models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
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
      child: MaterialApp(
        title: 'MusiKing',
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        home: Builder(
          builder: (context) => FutureBuilder(
            future: Provider.of<Songs>(context, listen: false)
                .setSongs()
                .then((_) => Provider.of<Songs>(context, listen: false)
                    .fetchAndSetCurrentSong())
                .then(
                  (_) => Future.delayed(
                    const Duration(seconds: 2),
                  ),
                ),
            builder: (context, snapshots) =>
                snapshots.connectionState == ConnectionState.waiting
                    ? const SplashScreen()
                    : const CustomBottomTab(),
          ),
        ),
        routes: {
          SplashScreen.routeName: (ctx) => const SplashScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          AlbumScreen.routeName: (ctx) => const AlbumScreen(),
          FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
          EqualizerScreen.routeName: (ctx) => const EqualizerScreen(),
          CustomBottomTab.routeName: (ctx) => const CustomBottomTab(),
        },
      ),
    );
  }
}
