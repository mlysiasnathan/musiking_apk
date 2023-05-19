import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './routes/screens.dart';
import './models/models.dart';

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
                fontFamily: 'PlusJakartaSans',
              ),
        ),
        home: const SplashScreen(),
        routes: {
          SplashScreen.routeName: (ctx) => const SplashScreen(),
          CustomTabScreenBottomBar.routeName: (ctx) =>
              const CustomTabScreenBottomBar(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          PlaylistScreen.routeName: (ctx) => const PlaylistScreen(),
          FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
          EqualizerScreen.routeName: (ctx) => const EqualizerScreen(),
        },
      ),
    );
  }
}
