import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musiking/routes/refresh_screen.dart';
import 'package:provider/provider.dart';
import 'package:musiking/helpers/constant.dart';
import 'package:musiking/routes/song_screen.dart';

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
        theme: lightMode1,
        darkTheme: darkMode1,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        // home: const CustomBottomTab(),

        home: Builder(
          builder: (context) => FutureBuilder(
            future: Future.delayed(const Duration(seconds: 3)).then(
              (_) => Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).isInit = true,
            ),
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
