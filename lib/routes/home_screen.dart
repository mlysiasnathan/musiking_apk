import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          DiscoverMusic(),
          AlbumMusic(),
          LocalPlaylistMusic(),
          // PlaylistMusic(),
          SizedBox(height: 43),
        ],
      ),
    );
  }
}
