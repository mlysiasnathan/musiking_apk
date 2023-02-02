import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomBar extends StatefulWidget {
  final int indexPage;
  const CustomBottomBar({
    this.indexPage = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  late int currentIndex = widget.indexPage;
  // final tabPages = [
  //   Get.toNamed('/'),
  //   Get.toNamed('/favorites'),
  //   Get.toNamed('/equalizer'),
  // ];

  @override
  Widget build(BuildContext context) {
    // assert(tabPages.length == navItems.length);

    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          currentIndex = index;
          // tabPages[currentIndex];
          print(currentIndex);
        });
      },
      elevation: 0,
      backgroundColor: Colors.transparent,
      currentIndex: currentIndex,
      unselectedItemColor: Colors.white70,
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: true,
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
              Icons.equalizer_outlined,
            ),
            activeIcon: Icon(
              Icons.equalizer,
            ),
            label: 'Equalizer'),
      ],
      // Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [
      //       Colors.red.withOpacity(0.8),
      //       Colors.orange.withOpacity(0.8),
      //     ],
      //   ),
      // ),
      // child:
      // Scaffold(
      //   appBar: null,
      //   body: tabPages[currentIndex],
      //   bottomNavigationBar:
      // =========================================
      //   ),
      // ),
      ///////
      // onTap: (index) {
      //   setState(() {
      //     currentIndex = index;
      //     tabPages[currentIndex];
      //     print(currentIndex);
      //   });
      // },
    );
  }
}
