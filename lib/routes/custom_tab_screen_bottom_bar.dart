import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/songs_provider_local.dart';
import './screens.dart';
import '../widgets/widgets.dart';

class CustomTabScreenBottomBar extends StatefulWidget {
  const CustomTabScreenBottomBar({
    // required this.indexPage,
    Key? key,
  }) : super(key: key);
  static const routeName = '/tabs-bottom-bar';

  @override
  State<CustomTabScreenBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomTabScreenBottomBar> {
  final PageController _controller = PageController();
  late List<Map<String, Object>> _pages;
  late int _selectedIndex = 0;
  void _selectPage(int index) {
    if (_selectedIndex != index) {
      _controller.jumpToPage(index);
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    _pages = [
      {'page': const HomeScreen()},
      {'page': const FavoritesScreen()},
      {'page': const EqualizerScreen()},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsLocal>(context, listen: false);
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color primaryColorDark = Theme.of(context).primaryColorDark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColorDark.withOpacity(0.8),
            primaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(),
        body: PageView(
          controller: _controller,
          onPageChanged: _selectPage,
          // children: _pages[_selectedIndex]['page'] as Widget,
          children: const [
            HomeScreen(),
            FavoritesScreen(),
            EqualizerScreen(),
          ],
        ),
        floatingActionButton: Consumer<SongsLocal>(
          builder: (ctx, songData, _) => songData.songs.isNotEmpty
              ? const PrePlayingSong()
              : const SizedBox(),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          selectedFontSize: 10,
          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedItemColor: Colors.white70,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.music_house,
                ),
                activeIcon: Icon(
                  CupertinoIcons.music_house_fill,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.heart,
                ),
                activeIcon: Icon(
                  CupertinoIcons.heart_fill,
                ),
                label: 'Favorites'),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.slider_horizontal_3,
                ),
                activeIcon: Icon(
                  CupertinoIcons.slider_horizontal_below_rectangle,
                ),
                label: 'Equalizer'),
          ],
        ),
      ),
    );
  }
}
