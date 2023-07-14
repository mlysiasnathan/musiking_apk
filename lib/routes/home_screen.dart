import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      key: const ValueKey('home'),
      child: Column(
        children: const [
          DiscoverMusic(),
          AlbumMusic(),
          LocalPlaylistMusic(),
          SizedBox(height: 43),
        ],
      ),
    );
  }
}
