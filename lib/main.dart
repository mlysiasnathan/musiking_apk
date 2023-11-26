import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// import './models/theme_provider.dart';
import './routes/screens.dart';
import './models/models.dart';
import './models/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => ThemeProvider(),
    //   child: const MyApp(),
    // ),
    const MyApp(),
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
          create: (ctx) => SongsLocal(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Playlists(),
        ),
      ],
      child: MaterialApp(
        title: 'MusiKing',
        debugShowCheckedModeBanner: false,
        // theme: Provider.of<ThemeProvider>(context).themeData,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.system,
        home: Builder(
          builder: (context) => FutureBuilder(
            future: Provider.of<SongsLocal>(context, listen: false)
                .setSongs()
                .then((_) => Provider.of<SongsLocal>(context, listen: false)
                    .fetchAndSetCurrentSong())
                .then(
                  (_) => Future.delayed(
                    const Duration(seconds: 2),
                  ),
                ),
            builder: (context, snapshots) =>
                snapshots.connectionState == ConnectionState.waiting
                    ? const SplashScreen()
                    : const CustomTabScreenBottomBar(),
          ),
        ),
        routes: {
          SplashScreen.routeName: (ctx) => const SplashScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          PlaylistScreen.routeName: (ctx) => const PlaylistScreen(),
          FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
          EqualizerScreen.routeName: (ctx) => const EqualizerScreen(),
          CustomTabScreenBottomBar.routeName: (ctx) =>
              const CustomTabScreenBottomBar(),
        },
      ),
    );
  }
}
